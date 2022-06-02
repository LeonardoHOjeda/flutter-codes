import 'package:flutter/material.dart';
import 'package:progra_movil/providers/movie_provider.dart';
import 'package:progra_movil/widgets/widgets.dart';
import 'package:provider/provider.dart';


class PracticeFourScreen extends StatelessWidget {

  static const String routerName = 'PracticeFour';

  @override
  Widget build(BuildContext context) {

    final moviesProvider = Provider.of<MoviesProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Practice 4 - Movies'),
        backgroundColor: Colors.green[800],
      ),
      drawer: SideMenu(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            MovieSlider(movies: moviesProvider.onDisplayMovies, title: 'En Cartelera'),
            MovieSlider(movies: moviesProvider.popularMovies, title: 'Populares'),
            MovieSlider(movies: moviesProvider.topRatedMovies, title: 'Mejor Calificados'),
          ],
        ),
      )
    );
  }
}