import 'package:animate_do/animate_do.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:wonk_app/application/router/router.gr.dart';
import 'package:wonk_app/domain/services/auth_service.dart';

@RoutePage()
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);
    final size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBody: true,
      body: SafeArea(
        child: SizedBox(
          height: size.height,
          width: size.width,
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 500),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  FadeInUp(
                    duration: const Duration(milliseconds: 1000),
                    child: Text(
                      AppLocalizations.of(context)!.login,
                      style: theme.textTheme.h1,
                    ),
                  ),
                  FadeInUp(
                    duration: const Duration(milliseconds: 1200),
                    child: Text(
                      AppLocalizations.of(context)!.loginDescrition,
                      style: theme.textTheme.muted,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Column(
                      children: <Widget>[
                        FadeInUp(
                          duration: const Duration(milliseconds: 1200),
                          child: ShadInputFormField(
                            label: Text(AppLocalizations.of(context)!.email),
                            placeholder: const Text("emirchus@mail.com"),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        FadeInUp(
                          duration: const Duration(milliseconds: 1300),
                          child: ShadInputFormField(
                            label: Text(AppLocalizations.of(context)!.password),
                            placeholder: const Text("********"),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  FadeInUp(
                    duration: const Duration(milliseconds: 1400),
                    child: ShadButton(
                      width: size.width * 0.8,
                      size: ShadButtonSize.lg,
                      onPressed: () {
                        // context.navigateTo(const HomeRoute());
                      },
                      child: Text(AppLocalizations.of(context)!.loginButton),
                    ),
                  ),
                  FadeInUp(
                    duration: const Duration(milliseconds: 1400),
                    child: ShadButton(
                      width: size.width * 0.8,
                      size: ShadButtonSize.lg,
                      onPressed: () async {
                        final result = await GetIt.I<AuthService>().loginWithGoogle();

                        result.fold((l) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(l.toString()),
                          ));
                        }, (r) {
                          context.navigateTo(const SplashRoute());
                        });
                      },
                      icon: const Icon(PhosphorIconsBold.googleLogo),
                      child: Text(AppLocalizations.of(context)!.loginWithGoogle),
                    ),
                  ),
                  FadeInUp(
                    duration: const Duration(milliseconds: 1500),
                    child: ShadButton.secondary(
                      width: size.width * 0.8,
                      child: Text(AppLocalizations.of(context)!.register),
                      onPressed: () {
                        context.navigateTo(const SignupRoute());
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
