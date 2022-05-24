import 'package:flutter/material.dart';
import 'package:progra_movil/widgets/widgets.dart';


class HomeScreen extends StatelessWidget {

  static const String routerName = 'Home';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Programacion Movil'),
        backgroundColor: Colors.green[800],
      ),
      drawer: SideMenu(),
      body: Center(
        child: Text('Hola Mundo'),
      ),
    );
  }
}