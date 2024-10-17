// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i9;
import 'package:wonk_app/presentation/screens/coffee/coffee_map_page.dart'
    as _i1;
import 'package:wonk_app/presentation/screens/coffee/new_coffee_page.dart'
    as _i4;
import 'package:wonk_app/presentation/screens/home_page.dart' as _i2;
import 'package:wonk_app/presentation/screens/login_page.dart' as _i3;
import 'package:wonk_app/presentation/screens/profile/profile_page.dart' as _i5;
import 'package:wonk_app/presentation/screens/settings_page.dart' as _i6;
import 'package:wonk_app/presentation/screens/signup_page.dart' as _i7;
import 'package:wonk_app/presentation/screens/splash_screen.dart'
    deferred as _i8;

/// generated route for
/// [_i1.CoffeeMapPage]
class CoffeeMapRoute extends _i9.PageRouteInfo<void> {
  const CoffeeMapRoute({List<_i9.PageRouteInfo>? children})
      : super(
          CoffeeMapRoute.name,
          initialChildren: children,
        );

  static const String name = 'CoffeeMapRoute';

  static _i9.PageInfo page = _i9.PageInfo(
    name,
    builder: (data) {
      return const _i1.CoffeeMapPage();
    },
  );
}

/// generated route for
/// [_i2.HomePage]
class HomeRoute extends _i9.PageRouteInfo<void> {
  const HomeRoute({List<_i9.PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static _i9.PageInfo page = _i9.PageInfo(
    name,
    builder: (data) {
      return const _i2.HomePage();
    },
  );
}

/// generated route for
/// [_i3.LoginPage]
class LoginRoute extends _i9.PageRouteInfo<void> {
  const LoginRoute({List<_i9.PageRouteInfo>? children})
      : super(
          LoginRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoginRoute';

  static _i9.PageInfo page = _i9.PageInfo(
    name,
    builder: (data) {
      return const _i3.LoginPage();
    },
  );
}

/// generated route for
/// [_i4.NewCoffeePage]
class NewCoffeeRoute extends _i9.PageRouteInfo<void> {
  const NewCoffeeRoute({List<_i9.PageRouteInfo>? children})
      : super(
          NewCoffeeRoute.name,
          initialChildren: children,
        );

  static const String name = 'NewCoffeeRoute';

  static _i9.PageInfo page = _i9.PageInfo(
    name,
    builder: (data) {
      return const _i4.NewCoffeePage();
    },
  );
}

/// generated route for
/// [_i5.ProfilePage]
class ProfileRoute extends _i9.PageRouteInfo<void> {
  const ProfileRoute({List<_i9.PageRouteInfo>? children})
      : super(
          ProfileRoute.name,
          initialChildren: children,
        );

  static const String name = 'ProfileRoute';

  static _i9.PageInfo page = _i9.PageInfo(
    name,
    builder: (data) {
      return const _i5.ProfilePage();
    },
  );
}

/// generated route for
/// [_i6.SettingsPage]
class SettingsRoute extends _i9.PageRouteInfo<void> {
  const SettingsRoute({List<_i9.PageRouteInfo>? children})
      : super(
          SettingsRoute.name,
          initialChildren: children,
        );

  static const String name = 'SettingsRoute';

  static _i9.PageInfo page = _i9.PageInfo(
    name,
    builder: (data) {
      return const _i6.SettingsPage();
    },
  );
}

/// generated route for
/// [_i7.SignupPage]
class SignupRoute extends _i9.PageRouteInfo<void> {
  const SignupRoute({List<_i9.PageRouteInfo>? children})
      : super(
          SignupRoute.name,
          initialChildren: children,
        );

  static const String name = 'SignupRoute';

  static _i9.PageInfo page = _i9.PageInfo(
    name,
    builder: (data) {
      return const _i7.SignupPage();
    },
  );
}

/// generated route for
/// [_i8.SplashScreen]
class SplashRoute extends _i9.PageRouteInfo<void> {
  const SplashRoute({List<_i9.PageRouteInfo>? children})
      : super(
          SplashRoute.name,
          initialChildren: children,
        );

  static const String name = 'SplashRoute';

  static _i9.PageInfo page = _i9.PageInfo(
    name,
    builder: (data) {
      return _i9.DeferredWidget(
        _i8.loadLibrary,
        () => _i8.SplashScreen(),
      );
    },
  );
}
