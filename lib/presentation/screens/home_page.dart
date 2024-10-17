import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:wonk_app/application/router/router.gr.dart';
import 'package:wonk_app/application/signals/user_signal.dart';

@RoutePage()
class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  HomePageState createState() => HomePageState();
}

class RouteDestination {
  final PageRouteInfo route;
  final Widget icon;
  final String label;

  const RouteDestination({
    required this.route,
    required this.icon,
    required this.label,
  });
}

class HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late final destinations = [
    RouteDestination(
      route: const CoffeeMapRoute(),
      icon: const Icon(PhosphorIconsRegular.coffee),
      label: AppLocalizations.of(context)!.coffees,
    ),
    RouteDestination(
      route: const NewCoffeeRoute(),
      icon: const Icon(PhosphorIconsRegular.mapPinPlus),
      label: AppLocalizations.of(context)!.newCoffees,
    ),
    RouteDestination(
      route: const SettingsRoute(),
      icon: const Icon(PhosphorIconsRegular.gear),
      label: AppLocalizations.of(context)!.settings,
    ),
  ];

  @override
  Widget build(context) {
    if (kIsWeb) {
      return AutoRouter(builder: (context, child) {
        var activeIndex = destinations.indexWhere(
          (d) => context.router.isRouteActive(d.route.routeName),
        );

        if (activeIndex == -1) {
          activeIndex = 0;
        }
        return Row(
          children: [
            NavigationRail(
              groupAlignment: -.5,
              selectedIndex: activeIndex,
              labelType: NavigationRailLabelType.all,
              leading: Column(
                children: [
                  const SizedBox(height: 16),
                  FloatingActionButton(
                    elevation: 0,
                    onPressed: () {
                      // Add your onPressed code here!
                    },
                    child: const Icon(PhosphorIconsRegular.magnifyingGlass),
                  ),
                  const SizedBox(height: 36)
                ],
              ),
              destinations: destinations
                  .map((d) => NavigationRailDestination(
                        icon: FittedBox(
                          child: d.icon,
                        ),
                        label: Text(d.label),
                      ))
                  .toList(),
              trailing: Expanded(
                flex: 4,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: const Icon(
                          PhosphorIconsBold.signOut,
                          size: 24,
                        ),
                        onPressed: () {},
                      ),
                      const SizedBox(height: 24),
                      GestureDetector(
                        onTap: () {
                          context.navigateTo(const ProfileRoute());
                        },
                        child: ShadAvatar(
                          userSignal.value?.photoUrl ?? '',
                          placeholder: Text(userSignal.value?.name.characters.first ?? ''),
                          fit: BoxFit.cover,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              onDestinationSelected: (index) {
                context.router.navigate(destinations[index].route);
              },
            ),
            const VerticalDivider(thickness: 1, width: 1),
            Expanded(child: child)
          ],
        );
      });
    }

    return const AutoRouter();
  }
}
