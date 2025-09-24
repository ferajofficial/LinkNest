// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i7;
import 'package:link_nest/features/counter/view/counter_page.dart'
    deferred as _i1;
import 'package:link_nest/features/home/view/home_page.dart' deferred as _i2;
import 'package:link_nest/features/onboarding/views/onboarding_page.dart'
    deferred as _i3;
import 'package:link_nest/features/profile/view/profile_page.dart'
    deferred as _i4;
import 'package:link_nest/features/signin/view/signin_page.dart'
    deferred as _i5;
import 'package:link_nest/features/signup/view/signup_page.dart'
    deferred as _i6;

/// generated route for
/// [_i1.CounterPage]
class CounterRoute extends _i7.PageRouteInfo<void> {
  const CounterRoute({List<_i7.PageRouteInfo>? children})
      : super(CounterRoute.name, initialChildren: children);

  static const String name = 'CounterRoute';

  static _i7.PageInfo page = _i7.PageInfo(
    name,
    builder: (data) {
      return _i7.DeferredWidget(_i1.loadLibrary, () => _i1.CounterPage());
    },
  );
}

/// generated route for
/// [_i2.HomePage]
class HomeRoute extends _i7.PageRouteInfo<void> {
  const HomeRoute({List<_i7.PageRouteInfo>? children})
      : super(HomeRoute.name, initialChildren: children);

  static const String name = 'HomeRoute';

  static _i7.PageInfo page = _i7.PageInfo(
    name,
    builder: (data) {
      return _i7.DeferredWidget(_i2.loadLibrary, () => _i2.HomePage());
    },
  );
}

/// generated route for
/// [_i3.OnboardingPage]
class OnboardingRoute extends _i7.PageRouteInfo<void> {
  const OnboardingRoute({List<_i7.PageRouteInfo>? children})
      : super(OnboardingRoute.name, initialChildren: children);

  static const String name = 'OnboardingRoute';

  static _i7.PageInfo page = _i7.PageInfo(
    name,
    builder: (data) {
      return _i7.DeferredWidget(_i3.loadLibrary, () => _i3.OnboardingPage());
    },
  );
}

/// generated route for
/// [_i4.ProfilePage]
class ProfileRoute extends _i7.PageRouteInfo<void> {
  const ProfileRoute({List<_i7.PageRouteInfo>? children})
      : super(ProfileRoute.name, initialChildren: children);

  static const String name = 'ProfileRoute';

  static _i7.PageInfo page = _i7.PageInfo(
    name,
    builder: (data) {
      return _i7.DeferredWidget(_i4.loadLibrary, () => _i4.ProfilePage());
    },
  );
}

/// generated route for
/// [_i5.SigninPage]
class SigninRoute extends _i7.PageRouteInfo<void> {
  const SigninRoute({List<_i7.PageRouteInfo>? children})
      : super(SigninRoute.name, initialChildren: children);

  static const String name = 'SigninRoute';

  static _i7.PageInfo page = _i7.PageInfo(
    name,
    builder: (data) {
      return _i7.DeferredWidget(_i5.loadLibrary, () => _i5.SigninPage());
    },
  );
}

/// generated route for
/// [_i6.SignupPage]
class SignupRoute extends _i7.PageRouteInfo<void> {
  const SignupRoute({List<_i7.PageRouteInfo>? children})
      : super(SignupRoute.name, initialChildren: children);

  static const String name = 'SignupRoute';

  static _i7.PageInfo page = _i7.PageInfo(
    name,
    builder: (data) {
      return _i7.DeferredWidget(_i6.loadLibrary, () => _i6.SignupPage());
    },
  );
}
