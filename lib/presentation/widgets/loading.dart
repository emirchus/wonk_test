import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: RiveAnimation.asset(
        'assets/rive/loading.riv',
        alignment: Alignment.center,
      ),
    );
  }
}
