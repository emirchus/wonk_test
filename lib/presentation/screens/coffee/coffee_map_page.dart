import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:latlong2/latlong.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:wonk_app/application/router/router.gr.dart';
import 'package:wonk_app/application/signals/geolocation_signal.dart';
import 'package:wonk_app/application/signals/stores_signal.dart';
import 'package:wonk_app/application/signals/user_signal.dart';
import 'package:wonk_app/presentation/widgets/navigation_bar.dart';
import 'package:wonk_app/presentation/widgets/starred_stores.dart';
import 'package:wonk_app/presentation/widgets/store_modal_sheet.dart';

@RoutePage()
class CoffeeMapPage extends StatefulWidget {
  const CoffeeMapPage({super.key});

  @override
  State<CoffeeMapPage> createState() => _CoffeeMapPageState();
}

class _CoffeeMapPageState extends State<CoffeeMapPage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final perfectSizeForMarker = (size.shortestSide * MediaQuery.devicePixelRatioOf(context)) / 20;

    return Scaffold(
      bottomNavigationBar: const Navbar(),
      extendBodyBehindAppBar: true,
      extendBody: true,
      body: Stack(
        children: [
          FlutterMap(
            options: MapOptions(
              initialCenter: LatLng(positionSignal.value.$1, positionSignal.value.$2),
              initialZoom: 9.2,
              interactionOptions: const InteractionOptions(
                flags: InteractiveFlag.pinchZoom | InteractiveFlag.drag | InteractiveFlag.doubleTapZoom | InteractiveFlag.scrollWheelZoom,
              ),
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'dev.emirchus.wonk_app',
              ),
              MarkerClusterLayerWidget(
                options: MarkerClusterLayerOptions(
                  maxClusterRadius: 45,
                  showPolygon: false,
                  spiderfyCluster: false,
                  size: const Size(40, 40),
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(50),
                  // maxZoom: 15,
                  markers: coffeeStoresSignal.value.where((store) => store.location != null).map<Marker>((store) {
                    return Marker(
                      width: perfectSizeForMarker,
                      height: perfectSizeForMarker,
                      point: LatLng(store.location!.lat, store.location!.lng),
                      child: GestureDetector(
                        onTap: () => StoreModalSheet.show(context, store: store),
                        child: FittedBox(
                          child: Image.asset('assets/images/marker.png', width: 80, height: 80),
                        ),
                      ),
                    );
                  }).toList(),
                  builder: (context, markers) {
                    return Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: const Color(0xffF69650).withOpacity(0.8),
                        border: Border.all(
                          color: const Color(0xffF69650).withOpacity(0.5),
                          width: 8,
                          strokeAlign: 1,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          markers.length.toString(),
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
          const Positioned(
            bottom: 100,
            child: StarredStores(),
          ),
          if (!kIsWeb)
            Positioned(
              top: MediaQuery.paddingOf(context).top + 8.0,
              left: 8,
              child: GestureDetector(
                onTap: () => context.navigateTo(const ProfileRoute()),
                child: Container(
                  padding: const EdgeInsets.all(4.0),
                  decoration: BoxDecoration(
                    color: ShadTheme.of(context).primaryButtonTheme.foregroundColor,
                    shape: BoxShape.circle,
                  ),
                  child: ShadAvatar(
                    userSignal.value?.photoUrl ?? '',
                    placeholder: Text((userSignal.value?.name ?? "NoAvailable").characters.first.toUpperCase()),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
