import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:wonk_app/application/signals/geolocation_signal.dart';
import 'package:wonk_app/application/signals/stores_signal.dart';
import 'package:wonk_app/application/signals/user_signal.dart';
import 'package:wonk_app/application/utils/geolocator.dart';
import 'package:wonk_app/domain/repositories/coffee_repository.dart';
import 'package:wonk_app/domain/services/auth_service.dart';
import 'package:wonk_app/presentation/widgets/loading.dart';

@RoutePage(deferredLoading: true)
class SplashScreen extends StatefulWidget {
  const SplashScreen({
    super.key,
  });

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _isLoaded = false;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final coffeeRepository = GetIt.I<CoffeeRepository>();

      final storesResponse = await coffeeRepository.getCoffees();
      final userResponse = await GetIt.I<AuthService>().getCurrentUser();

      if (storesResponse.isRight) {
        coffeeStoresSignal.set(storesResponse.right);
      }

      if (userResponse.isRight) {
        userSignal.set(userResponse.right);
      }

      final position = await determinePosition();

      if (position.isRight) {
        positionSignal.set(position.right);
      }

      setState(() {
        _isLoaded = true;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (!_isLoaded) {
      return const Scaffold(
        extendBody: true,
        body: SizedBox.expand(
          child: LoadingWidget(),
        ),
      );
    }

    return const AutoRouter();
  }
}
