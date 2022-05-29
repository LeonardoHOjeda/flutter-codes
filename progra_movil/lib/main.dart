import 'package:flutter/material.dart';
import 'package:progra_movil/screens/practice_four.dart';
import 'package:progra_movil/screens/practice_two.dart';
import 'package:progra_movil/screens/screens.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {

  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      initialRoute: HomeScreen.routerName,
      routes: {
        HomeScreen.routerName         : (_) =>  HomeScreen(),
        PracticeTwoScreen.routerName: (_) =>  PracticeTwoScreen(),
        PracticeThreeScreen.routerName: (_) =>  PracticeThreeScreen(),
        PracticeFourScreen.routerName: (_) =>  PracticeFourScreen(),
      },
    );
  }
}
