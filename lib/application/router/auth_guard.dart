//ignore_for_file: public_member_api_docs
import 'package:auto_route/auto_route.dart';
import 'package:get_it/get_it.dart';
import 'package:wonk_app/application/router/router.gr.dart';
import 'package:wonk_app/domain/services/auth_service.dart';

class AuthGuard extends AutoRouteGuard {
  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) async {
    final authService = GetIt.I<AuthService>();
    final user = await authService.getCurrentUser();

    if (user.isRight || resolver.routeName == LoginRoute.name || resolver.routeName == SignupRoute.name || resolver.routeName == SplashRoute.name) {
      resolver.next(true);
    } else {
      resolver.redirect(
        const LoginRoute(),
      );
    }
  }
}
