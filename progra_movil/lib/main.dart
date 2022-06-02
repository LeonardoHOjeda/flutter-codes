import 'package:flutter/material.dart';
import 'package:progra_movil/providers/movie_provider.dart';
import 'package:progra_movil/screens/details_movie_screen.dart';
import 'package:progra_movil/screens/practice_four.dart';
import 'package:progra_movil/screens/practice_two.dart';
import 'package:progra_movil/screens/screens.dart';
import 'package:provider/provider.dart';

void main() => runApp(AppState());

class AppState extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MoviesProvider(), lazy: false,)
      ],
      child: MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {

  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Practicas',
      initialRoute: HomeScreen.routerName,
      routes: {
        HomeScreen.routerName         : (_) =>  HomeScreen(),
        PracticeTwoScreen.routerName: (_) =>  PracticeTwoScreen(),
        PracticeThreeScreen.routerName: (_) =>  PracticeThreeScreen(),
        PracticeFourScreen.routerName: (_) =>  PracticeFourScreen(),
        DetailsMovieScreen.routerName: (_) => DetailsMovieScreen()
      },
    );
  }
}
