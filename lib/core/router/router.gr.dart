// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i11;
import 'package:collection/collection.dart' as _i13;
import 'package:flutter/material.dart' as _i12;
import 'package:link_nest/features/collections/collection_details_page.dart'
    as _i1;
import 'package:link_nest/features/collections/collection_page.dart' as _i2;
import 'package:link_nest/features/counter/view/counter_page.dart'
    deferred as _i3;
import 'package:link_nest/features/home/view/home_page.dart' deferred as _i4;
import 'package:link_nest/features/nav_bar/nav_bar_page.dart' as _i5;
import 'package:link_nest/features/onboarding/views/onboarding_page.dart'
    deferred as _i6;
import 'package:link_nest/features/profile/view/profile_page.dart'
    deferred as _i7;
import 'package:link_nest/features/signin/view/signin_page.dart'
    deferred as _i8;
import 'package:link_nest/features/signup/view/signup_page.dart'
    deferred as _i9;
import 'package:link_nest/features/tags/tags_page.dart' as _i10;

/// generated route for
/// [_i1.CollectionDetailPage]
class CollectionDetailRoute
    extends _i11.PageRouteInfo<CollectionDetailRouteArgs> {
  CollectionDetailRoute({
    _i12.Key? key,
    required String collectionName,
    required List<_i12.Color> gradientColors,
    String? collectionId,
    List<_i11.PageRouteInfo>? children,
  }) : super(
          CollectionDetailRoute.name,
          args: CollectionDetailRouteArgs(
            key: key,
            collectionName: collectionName,
            gradientColors: gradientColors,
            collectionId: collectionId,
          ),
          initialChildren: children,
        );

  static const String name = 'CollectionDetailRoute';

  static _i11.PageInfo page = _i11.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<CollectionDetailRouteArgs>();
      return _i1.CollectionDetailPage(
        key: args.key,
        collectionName: args.collectionName,
        gradientColors: args.gradientColors,
        collectionId: args.collectionId,
      );
    },
  );
}

class CollectionDetailRouteArgs {
  const CollectionDetailRouteArgs({
    this.key,
    required this.collectionName,
    required this.gradientColors,
    this.collectionId,
  });

  final _i12.Key? key;

  final String collectionName;

  final List<_i12.Color> gradientColors;

  final String? collectionId;

  @override
  String toString() {
    return 'CollectionDetailRouteArgs{key: $key, collectionName: $collectionName, gradientColors: $gradientColors, collectionId: $collectionId}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! CollectionDetailRouteArgs) return false;
    return key == other.key &&
        collectionName == other.collectionName &&
        const _i13.ListEquality().equals(
          gradientColors,
          other.gradientColors,
        ) &&
        collectionId == other.collectionId;
  }

  @override
  int get hashCode =>
      key.hashCode ^
      collectionName.hashCode ^
      const _i13.ListEquality().hash(gradientColors) ^
      collectionId.hashCode;
}

/// generated route for
/// [_i2.CollectionPage]
class CollectionRoute extends _i11.PageRouteInfo<void> {
  const CollectionRoute({List<_i11.PageRouteInfo>? children})
      : super(CollectionRoute.name, initialChildren: children);

  static const String name = 'CollectionRoute';

  static _i11.PageInfo page = _i11.PageInfo(
    name,
    builder: (data) {
      return const _i2.CollectionPage();
    },
  );
}

/// generated route for
/// [_i3.CounterPage]
class CounterRoute extends _i11.PageRouteInfo<void> {
  const CounterRoute({List<_i11.PageRouteInfo>? children})
      : super(CounterRoute.name, initialChildren: children);

  static const String name = 'CounterRoute';

  static _i11.PageInfo page = _i11.PageInfo(
    name,
    builder: (data) {
      return _i11.DeferredWidget(_i3.loadLibrary, () => _i3.CounterPage());
    },
  );
}

/// generated route for
/// [_i4.HomePage]
class HomeRoute extends _i11.PageRouteInfo<void> {
  const HomeRoute({List<_i11.PageRouteInfo>? children})
      : super(HomeRoute.name, initialChildren: children);

  static const String name = 'HomeRoute';

  static _i11.PageInfo page = _i11.PageInfo(
    name,
    builder: (data) {
      return _i11.DeferredWidget(_i4.loadLibrary, () => _i4.HomePage());
    },
  );
}

/// generated route for
/// [_i5.NavBarPage]
class NavBarRoute extends _i11.PageRouteInfo<void> {
  const NavBarRoute({List<_i11.PageRouteInfo>? children})
      : super(NavBarRoute.name, initialChildren: children);

  static const String name = 'NavBarRoute';

  static _i11.PageInfo page = _i11.PageInfo(
    name,
    builder: (data) {
      return const _i5.NavBarPage();
    },
  );
}

/// generated route for
/// [_i6.OnboardingPage]
class OnboardingRoute extends _i11.PageRouteInfo<void> {
  const OnboardingRoute({List<_i11.PageRouteInfo>? children})
      : super(OnboardingRoute.name, initialChildren: children);

  static const String name = 'OnboardingRoute';

  static _i11.PageInfo page = _i11.PageInfo(
    name,
    builder: (data) {
      return _i11.DeferredWidget(_i6.loadLibrary, () => _i6.OnboardingPage());
    },
  );
}

/// generated route for
/// [_i7.ProfilePage]
class ProfileRoute extends _i11.PageRouteInfo<void> {
  const ProfileRoute({List<_i11.PageRouteInfo>? children})
      : super(ProfileRoute.name, initialChildren: children);

  static const String name = 'ProfileRoute';

  static _i11.PageInfo page = _i11.PageInfo(
    name,
    builder: (data) {
      return _i11.DeferredWidget(_i7.loadLibrary, () => _i7.ProfilePage());
    },
  );
}

/// generated route for
/// [_i8.SigninPage]
class SigninRoute extends _i11.PageRouteInfo<void> {
  const SigninRoute({List<_i11.PageRouteInfo>? children})
      : super(SigninRoute.name, initialChildren: children);

  static const String name = 'SigninRoute';

  static _i11.PageInfo page = _i11.PageInfo(
    name,
    builder: (data) {
      return _i11.DeferredWidget(_i8.loadLibrary, () => _i8.SigninPage());
    },
  );
}

/// generated route for
/// [_i9.SignupPage]
class SignupRoute extends _i11.PageRouteInfo<void> {
  const SignupRoute({List<_i11.PageRouteInfo>? children})
      : super(SignupRoute.name, initialChildren: children);

  static const String name = 'SignupRoute';

  static _i11.PageInfo page = _i11.PageInfo(
    name,
    builder: (data) {
      return _i11.DeferredWidget(_i9.loadLibrary, () => _i9.SignupPage());
    },
  );
}

/// generated route for
/// [_i10.TagsPage]
class TagsRoute extends _i11.PageRouteInfo<void> {
  const TagsRoute({List<_i11.PageRouteInfo>? children})
      : super(TagsRoute.name, initialChildren: children);

  static const String name = 'TagsRoute';

  static _i11.PageInfo page = _i11.PageInfo(
    name,
    builder: (data) {
      return const _i10.TagsPage();
    },
  );
}
