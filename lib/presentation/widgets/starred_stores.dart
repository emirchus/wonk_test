import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:wonk_app/application/signals/geolocation_signal.dart';
import 'package:wonk_app/domain/models/cafes.dart';
import 'package:wonk_app/domain/repositories/coffee_repository.dart';
import 'package:wonk_app/presentation/widgets/coffee_store_card.dart';
import 'package:wonk_app/presentation/widgets/store_modal_sheet.dart';

class StarredStores extends StatefulWidget {
  const StarredStores({super.key});

  @override
  State<StarredStores> createState() => _StarredStoresState();
}

class _StarredStoresState extends State<StarredStores> {
  List<Cafes> stores = [];


  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final lat = positionSignal.value.$1;
      final lng = positionSignal.value.$2;

      final result = await GetIt.I<CoffeeRepository>().getCoffeeByLatLng(lat, lng);

      result.fold((l) {}, (r) {
        stores = r;
      });

      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return AnimatedOpacity(
      duration: const Duration(milliseconds: 300),
      opacity: stores.isEmpty ? 0 : 1,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        transform: Matrix4.translationValues(0, stores.isEmpty ? 10 : 0, 0),
        height: 250,
        width: size.width,
        child: CarouselView(
          itemExtent: 350,
          shrinkExtent: 200,
          onTap: (index) {
            final store = stores[index];

            StoreModalSheet.show(context, store: store);
          },
          children: stores.map<Widget>((store) {
            return CoffeeStoreCard(
              cafe: store,
            );
          }).toList(),
        ),
      ),
    );
  }
}
