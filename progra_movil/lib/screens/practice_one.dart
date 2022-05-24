import 'package:flutter/material.dart';


class PracticeOneScreen extends StatelessWidget {

  static const String routerName = 'PracticeOne';


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Practica Uno'),
        backgroundColor: Colors.green[800],
      ),
      body: Center(
        child: Text('Hola Mundo'),
      ),
    );
  }
}