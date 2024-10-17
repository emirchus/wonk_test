import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:wonk_app/application/router/router.dart';
import 'package:flutter_solidart/flutter_solidart.dart';
import 'package:wonk_app/application/signals/theme_mode.dart';

class Application extends StatelessWidget {
  final _appRouter = AppRouter();

  Application({super.key});

  @override
  Widget build(BuildContext context) {
    return SignalBuilder(
      signal: themeMode,
      builder: (context, value, _) {
        return ShadApp.materialRouter(
          debugShowCheckedModeBanner: false,
          restorationScopeId: 'app',
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('en', ''),
            Locale('es', ''),
          ],
          onGenerateTitle: (BuildContext context) => AppLocalizations.of(context)!.appTitle,
          themeMode: value,
          theme: ShadThemeData(
            colorScheme: const ShadStoneColorScheme.light(),
            brightness: Brightness.light,
          ),
          darkTheme: ShadThemeData(
            colorScheme: const ShadStoneColorScheme.dark(),
            brightness: Brightness.dark,
          ),
          routerConfig: _appRouter.config(includePrefixMatches: false),
        );
      },
    );
  }
}
