// import 'package:auto_route/auto_route.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:link_nest/core/router/router.gr.dart';
// import 'package:link_nest/data/providers/auth/auth_repo_provider.dart';

// class AuthGuard extends AutoRouteGuard {
//   final WidgetRef ref;

//   AuthGuard(this.ref);

//   @override
//   void onNavigation(NavigationResolver resolver, StackRouter router) {
//     final authRepo = ref.read(authRepositoryProvider);
//     final user = authRepo.currentUser;
//     final seenOnboarding = authRepo.hasSeenOnboarding();

//     // Check if user is trying to access a protected route
//     if (resolver.route.name == HomeRoute.name ||
//         resolver.route.name == ProfileRoute.name ||
//         resolver.route.name == CounterRoute.name) {
//       if (user != null) {
//         // User is logged in, allow access
//         resolver.next(true);
//       } else {
//         // User not logged in, redirect to signin or onboarding
//         if (seenOnboarding) {
//           resolver.redirect(SigninRoute());
//         } else {
//           resolver.redirect(OnboardingRoute());
//         }
//       }
//     }
//     // Check if user is trying to access auth screens when already logged in
//     else if (resolver.route.name == SigninRoute.name ||
//         resolver.route.name == SignupRoute.name ||
//         resolver.route.name == OnboardingRoute.name) {
//       if (user != null) {
//         // User already logged in, redirect to home
//         resolver.redirect(HomeRoute());
//       } else {
//         resolver.next(true);
//       }
//     } else {
//       // Allow navigation for other routes
//       resolver.next(true);
//     }
//   }
// }

import 'package:auto_route/auto_route.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:link_nest/core/router/router.gr.dart';
import 'package:link_nest/data/providers/auth/auth_repo_provider.dart';

// class AuthGuard extends AutoRouteGuard {
//   final WidgetRef ref;

//   AuthGuard(this.ref);

//   @override
//   void onNavigation(NavigationResolver resolver, StackRouter router) {
//     final authRepo = ref.read(authRepositoryProvider);
//     final user = authRepo.currentUser;
//     final seenOnboarding = authRepo.hasSeenOnboarding();

//     final routeName = resolver.route.name;
//     final isAuthenticated = user != null;

//     // Define protected routes (require authentication)
//     final protectedRoutes = [
//       HomeRoute.name,
//       ProfileRoute.name,
//       CounterRoute.name,
//     ];

//     // Define auth routes (shouldn't be accessed when logged in)
//     final authRoutes = [
//       SigninRoute.name,
//       SignupRoute.name,
//       OnboardingRoute.name,
//     ];

//     // Handle protected routes
//     if (protectedRoutes.contains(routeName)) {
//       if (isAuthenticated) {
//         // User is authenticated, allow access
//         resolver.next();
//       } else {
//         // User not authenticated, redirect to appropriate auth screen
//         if (seenOnboarding) {
//           resolver.redirectUntil(SigninRoute());
//         } else {
//           resolver.redirectUntil(OnboardingRoute());
//         }
//       }
//     }
//     // Handle auth routes
//     else if (authRoutes.contains(routeName)) {
//       if (isAuthenticated) {
//         // User already logged in, redirect to home ONLY if not already navigating there
//         if (router.current.name != HomeRoute.name) {
//           resolver.redirectUntil(HomeRoute());
//         } else {
//           resolver.next();
//         }
//       } else {
//         // User not logged in, allow access to auth screens
//         resolver.next();
//       }
//     }
//     // Allow navigation for any other routes
//     else {
//       resolver.next();
//     }
//   }
// }
class AuthGuard extends AutoRouteGuard {
  final WidgetRef ref;

  AuthGuard(this.ref);

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    final authRepo = ref.read(authRepositoryProvider);
    final user = authRepo.currentUser;
    final seenOnboarding = authRepo.hasSeenOnboarding();

    final routeName = resolver.route.name;
    final isAuthenticated = user != null;

    // Define protected routes (require authentication)
    final protectedRoutes = {
      HomeRoute.name,
      ProfileRoute.name,
      CounterRoute.name,
    };

    // Define auth routes (for non-authenticated users)
    final authRoutes = {
      SigninRoute.name,
      SignupRoute.name,
    };

    // 1. Handle protected routes (require login)
    if (protectedRoutes.contains(routeName)) {
      if (isAuthenticated) {
        resolver.next();
      } else {
        // Not logged in - redirect based on onboarding status
        resolver.redirectUntil(seenOnboarding ? SigninRoute() : OnboardingRoute());
      }
      return;
    }

    // 2. Handle auth routes (signin/signup)
    if (authRoutes.contains(routeName)) {
      if (isAuthenticated) {
        // Already logged in - go to home
        resolver.redirectUntil(HomeRoute());
      } else {
        resolver.next();
      }
      return;
    }

    // 3. Handle onboarding route
    if (routeName == OnboardingRoute.name) {
      if (isAuthenticated) {
        // Logged in user shouldn't see onboarding
        resolver.redirectUntil(HomeRoute());
      } else if (seenOnboarding) {
        // Already seen onboarding - go to signin
        resolver.redirectUntil(SigninRoute());
      } else {
        // First time - show onboarding
        resolver.next();
      }
      return;
    }

    // 4. Allow all other routes
    resolver.next();
  }
}
