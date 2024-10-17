//ignore_for_file: public_member_api_docs
import 'package:auto_route/auto_route.dart';
import 'package:wonk_app/application/router/auth_guard.dart';
import 'package:wonk_app/application/router/router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  final List<AutoRoute> routes = [
    AutoRoute(
      page: SplashRoute.page,
      initial: true,
      path: '/',
      children: [
        AutoRoute(
          path: '',
          page: HomeRoute.page,
          guards: [
            AuthGuard(),
          ],
          children: [
            AutoRoute(
              path: '',
              page: CoffeeMapRoute.page,
              title: (ctx, _) => 'Coffees',
            ),
            AutoRoute(page: NewCoffeeRoute.page, path: 'new'),
            AutoRoute(page: ProfileRoute.page, path: 'profile'),
            AutoRoute(page: SettingsRoute.page, path: 'settings'),
          ],
        ),
      ],
    ),
    AutoRoute(page: LoginRoute.page, path: '/login'),
    AutoRoute(page: SignupRoute.page, path: '/signup'),
    RedirectRoute(path: '*', redirectTo: '/'),
  ];
}
