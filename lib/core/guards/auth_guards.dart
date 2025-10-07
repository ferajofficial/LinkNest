import 'package:auto_route/auto_route.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:link_nest/core/router/router.gr.dart';
import 'package:link_nest/data/providers/auth/auth_repo_provider.dart';

class AuthGuard extends AutoRouteGuard {
  final WidgetRef ref;

  AuthGuard(this.ref);

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    final authRepo = ref.read(authRepositoryProvider);
    final user = authRepo.currentUser;
    final seenOnboarding = authRepo.hasSeenOnboarding();

    // Check if user is trying to access a protected route
    if (resolver.route.name == HomeRoute.name ||
        resolver.route.name == ProfileRoute.name ||
        resolver.route.name == CounterRoute.name) {
      if (user != null) {
        // User is logged in, allow access
        resolver.next(true);
      } else {
        // User not logged in, redirect to signin or onboarding
        if (seenOnboarding) {
          resolver.redirect(SigninRoute());
        } else {
          resolver.redirect(OnboardingRoute());
        }
      }
    }
    // Check if user is trying to access auth screens when already logged in
    else if (resolver.route.name == SigninRoute.name ||
        resolver.route.name == SignupRoute.name ||
        resolver.route.name == OnboardingRoute.name) {
      if (user != null) {
        // User already logged in, redirect to home
        resolver.redirect(HomeRoute());
      } else {
        resolver.next(true);
      }
    } else {
      // Allow navigation for other routes
      resolver.next(true);
    }
  }
}
