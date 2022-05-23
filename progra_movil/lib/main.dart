import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Programacion Movil',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Programacion Movil', style: TextStyle(color: Colors.black),),
          backgroundColor: Colors.lightGreenAccent,
          iconTheme: IconThemeData(color: Colors.black),
        ),
        body: Center(
          child: Text('My Page!')
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.green
                ), child: Text('Drawer Header'),
              ),
              ListTile(
                title: const Text('Practica 1'),
                onTap: (){},
              ),
              ListTile(
                title: const Text('Practica 2'),
                onTap: (){},
              ),
              ListTile(
                title: const Text('Practica 3'),
                onTap: (){},
              ),
              ListTile(
                title: const Text('Practica 4'),
                onTap: (){},
              ),
              ListTile(
                title: const Text('Practica 5'),
                onTap: (){},
              ),
            ],
          ),
        ),
      ),
    );
  }
}