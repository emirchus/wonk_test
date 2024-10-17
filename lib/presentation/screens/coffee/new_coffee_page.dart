import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class NewCoffeePage extends StatefulWidget {
  const NewCoffeePage({super.key});

  @override
  State<NewCoffeePage> createState() => _NewCoffeePageState();
}

class _NewCoffeePageState extends State<NewCoffeePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Hola Mundo'),
      ),
    );
  }
}
