import 'dart:ui';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wonk_app/application/extensions/separated_by.dart';
import 'package:wonk_app/application/router/router.gr.dart';

class Navbar extends StatelessWidget {
  const Navbar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    if (kIsWeb) {
      return const SizedBox();
    }

    return BottomAppBar(
      height: 100,
      color: Colors.transparent,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
          child: Container(
            decoration: BoxDecoration(
              color: ShadTheme.of(context).colorScheme.background.withOpacity(0.5),
              border: Border.all(
                color: ShadTheme.of(context).colorScheme.background.withOpacity(0.8),
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                NavButton(
                  icon: PhosphorIconsRegular.mapPinPlus,
                  onTap: () => context.navigateTo(const NewCoffeeRoute()),
                ),
                NavButton(
                  icon: PhosphorIconsRegular.coffee,
                  onTap: () {},
                ),
                NavButton(
                  icon: PhosphorIconsRegular.gear,
                  onTap: () => context.navigateTo(const SettingsRoute()),
                ),
                NavButton(
                  icon: PhosphorIconsRegular.magnifyingGlass,
                  onTap: () {},
                  text: AppLocalizations.of(context)!.search,
                ),
              ].separatedBy(const SizedBox(width: 4)),
            ),
          ),
        ),
      ),
    );
  }
}

class NavButton extends StatelessWidget {
  final IconData icon;
  final Function() onTap;
  final String? text;

  const NavButton({
    super.key,
    required this.icon,
    required this.onTap,
    this.text,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        height: ShadTheme.of(context).buttonSizesTheme.regular?.height,
        child: Container(
          decoration: BoxDecoration(
            color: ShadTheme.of(context).secondaryButtonTheme.backgroundColor?.withOpacity(0.7),
            borderRadius: BorderRadius.circular(20),
          ),
          padding: ShadTheme.of(context).buttonSizesTheme.regular?.padding ?? const EdgeInsets.all(8),
          child: Row(
            children: [
              if (text != null) ...[
                Text(
                  text!,
                  style: ShadTheme.of(context).textTheme.small,
                ),
                const SizedBox(width: 8),
              ],
              Icon(
                icon,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
