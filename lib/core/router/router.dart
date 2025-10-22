import 'package:auto_route/auto_route.dart';
import 'package:link_nest/core/guards/auth_guards.dart';
import 'package:link_nest/core/router/router.gr.dart';

/// This class used for defined routes and paths na dother properties
// @AutoRouterConfig()
// class AppRouter extends RootStackRouter {
//   @override
//   late final List<AutoRoute> routes = [
//     AutoRoute(
//       page: CounterRoute.page,
//       // path: '/',
//       // initial: true,
//     ),
//     AutoRoute(
//       page: HomeRoute.page,
//     ),
//     AutoRoute(
//       page: OnboardingRoute.page,
//       initial: true,
//     ),
//     AutoRoute(
//       page: ProfileRoute.page,
//     ),
//     AutoRoute(
//       page: SigninRoute.page,
//     ),
//     AutoRoute(
//       page: SignupRoute.page,
//     ),
//   ];
// }
@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  final AuthGuard? authGuard;

  AppRouter({this.authGuard});

  @override
  late final List<AutoRoute> routes = [
    // Protected routes - require authentication
    AutoRoute(
      page: HomeRoute.page,
    ),
    AutoRoute(
      page: ProfileRoute.page,
    ),
    AutoRoute(
      page: CounterRoute.page,
    ),
    AutoRoute(
      page: TagsRoute.page,
    ),
    AutoRoute(
      page: CollectionRoute.page,
    ),
    AutoRoute(
      page: NavBarRoute.page,
    ),

    // Auth routes - redirect to home if already authenticated
    AutoRoute(
      initial: true,
      page: OnboardingRoute.page,
      guards: authGuard != null ? [authGuard!] : [],
    ),
    AutoRoute(
      page: SigninRoute.page,
    ),
    AutoRoute(
      page: SignupRoute.page,
    ),
  ];
}
