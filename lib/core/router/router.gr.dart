// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i10;
import 'package:link_nest/features/counter/view/counter_page.dart'
    deferred as _i2;
import 'package:link_nest/features/folder_collections/folder_collection_page.dart'
    as _i1;
import 'package:link_nest/features/home/view/home_page.dart' deferred as _i3;
import 'package:link_nest/features/nav_bar/nav_bar_page.dart' as _i4;
import 'package:link_nest/features/onboarding/views/onboarding_page.dart'
    deferred as _i5;
import 'package:link_nest/features/profile/view/profile_page.dart'
    deferred as _i6;
import 'package:link_nest/features/signin/view/signin_page.dart'
    deferred as _i7;
import 'package:link_nest/features/signup/view/signup_page.dart'
    deferred as _i8;
import 'package:link_nest/features/tags/tags_page.dart' as _i9;

/// generated route for
/// [_i1.CollectionPage]
class CollectionRoute extends _i10.PageRouteInfo<void> {
  const CollectionRoute({List<_i10.PageRouteInfo>? children})
      : super(CollectionRoute.name, initialChildren: children);

  static const String name = 'CollectionRoute';

  static _i10.PageInfo page = _i10.PageInfo(
    name,
    builder: (data) {
      return const _i1.CollectionPage();
    },
  );
}

/// generated route for
/// [_i2.CounterPage]
class CounterRoute extends _i10.PageRouteInfo<void> {
  const CounterRoute({List<_i10.PageRouteInfo>? children})
      : super(CounterRoute.name, initialChildren: children);

  static const String name = 'CounterRoute';

  static _i10.PageInfo page = _i10.PageInfo(
    name,
    builder: (data) {
      return _i10.DeferredWidget(_i2.loadLibrary, () => _i2.CounterPage());
    },
  );
}

/// generated route for
/// [_i3.HomePage]
class HomeRoute extends _i10.PageRouteInfo<void> {
  const HomeRoute({List<_i10.PageRouteInfo>? children})
      : super(HomeRoute.name, initialChildren: children);

  static const String name = 'HomeRoute';

  static _i10.PageInfo page = _i10.PageInfo(
    name,
    builder: (data) {
      return _i10.DeferredWidget(_i3.loadLibrary, () => _i3.HomePage());
    },
  );
}

/// generated route for
/// [_i4.NavBarPage]
class NavBarRoute extends _i10.PageRouteInfo<void> {
  const NavBarRoute({List<_i10.PageRouteInfo>? children})
      : super(NavBarRoute.name, initialChildren: children);

  static const String name = 'NavBarRoute';

  static _i10.PageInfo page = _i10.PageInfo(
    name,
    builder: (data) {
      return const _i4.NavBarPage();
    },
  );
}

/// generated route for
/// [_i5.OnboardingPage]
class OnboardingRoute extends _i10.PageRouteInfo<void> {
  const OnboardingRoute({List<_i10.PageRouteInfo>? children})
      : super(OnboardingRoute.name, initialChildren: children);

  static const String name = 'OnboardingRoute';

  static _i10.PageInfo page = _i10.PageInfo(
    name,
    builder: (data) {
      return _i10.DeferredWidget(_i5.loadLibrary, () => _i5.OnboardingPage());
    },
  );
}

/// generated route for
/// [_i6.ProfilePage]
class ProfileRoute extends _i10.PageRouteInfo<void> {
  const ProfileRoute({List<_i10.PageRouteInfo>? children})
      : super(ProfileRoute.name, initialChildren: children);

  static const String name = 'ProfileRoute';

  static _i10.PageInfo page = _i10.PageInfo(
    name,
    builder: (data) {
      return _i10.DeferredWidget(_i6.loadLibrary, () => _i6.ProfilePage());
    },
  );
}

/// generated route for
/// [_i7.SigninPage]
class SigninRoute extends _i10.PageRouteInfo<void> {
  const SigninRoute({List<_i10.PageRouteInfo>? children})
      : super(SigninRoute.name, initialChildren: children);

  static const String name = 'SigninRoute';

  static _i10.PageInfo page = _i10.PageInfo(
    name,
    builder: (data) {
      return _i10.DeferredWidget(_i7.loadLibrary, () => _i7.SigninPage());
    },
  );
}

/// generated route for
/// [_i8.SignupPage]
class SignupRoute extends _i10.PageRouteInfo<void> {
  const SignupRoute({List<_i10.PageRouteInfo>? children})
      : super(SignupRoute.name, initialChildren: children);

  static const String name = 'SignupRoute';

  static _i10.PageInfo page = _i10.PageInfo(
    name,
    builder: (data) {
      return _i10.DeferredWidget(_i8.loadLibrary, () => _i8.SignupPage());
    },
  );
}

/// generated route for
/// [_i9.TagsPage]
class TagsRoute extends _i10.PageRouteInfo<void> {
  const TagsRoute({List<_i10.PageRouteInfo>? children})
      : super(TagsRoute.name, initialChildren: children);

  static const String name = 'TagsRoute';

  static _i10.PageInfo page = _i10.PageInfo(
    name,
    builder: (data) {
      return const _i9.TagsPage();
    },
  );
}
