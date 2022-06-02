import 'package:flutter/material.dart';
import 'package:progra_movil/widgets/widgets.dart';


class PracticeFourScreen extends StatelessWidget {

  static const String routerName = 'PracticeFour';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Practice 4 - Movies'),
        backgroundColor: Colors.green[800],
      ),
      drawer: SideMenu(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            MovieSlider(),
            MovieSlider(),
          ],
        ),
      )
    );
  }
}