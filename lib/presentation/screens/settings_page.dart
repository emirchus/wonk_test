import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

//ignore_for_file: public_member_api_docs
@RoutePage()
class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  var queryUpdateCont = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(),
    );
  }
}
