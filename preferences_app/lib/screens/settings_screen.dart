import 'package:flutter/material.dart';
import 'package:preferences_app/widgets/widgets.dart';


class SettingsScreen extends StatelessWidget {

  static const String routerName = 'Settings';

  const SettingsScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      drawer: SideMenu(),
      body: Center(
        child: Text('Hola Mundo'),
      ),
    );
  }
}