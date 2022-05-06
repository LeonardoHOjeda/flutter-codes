import 'package:flutter/material.dart';
import 'package:preferences_app/share_preferences/preferences.dart';
import 'package:preferences_app/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  static const String routerName = 'Home';

  const HomeScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Home'),
        ),
        drawer: SideMenu(),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Modo Oscuro: ${Preferences.isDarkmode}'),
            Divider(),
            Text('Genero: ${Preferences.gender}'),
            Divider(),
            Text('Username: ${Preferences.name}'),
            Divider(),
          ],
        ));
  }
}
