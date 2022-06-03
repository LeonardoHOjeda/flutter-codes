import 'package:flutter/material.dart';
import 'package:progra_movil/providers/movie_provider.dart';
import 'package:progra_movil/widgets/widgets.dart';
import 'package:provider/provider.dart';


class PracticeFourScreen extends StatelessWidget {

  static const String routerName = 'PracticeFour';

  @override
  Widget build(BuildContext context) {

    final moviesProvider = Provider.of<MoviesProvider>(context);
    return ChangeNotifierProvider(
      create: (_) => new _NavegacionModel(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Practice 4 - Movies'),
          backgroundColor: Colors.green[800],
        ),
        drawer: SideMenu(),
        body: _Pages(moviesProvider: moviesProvider),
        bottomNavigationBar: _Navigation(),
      ),
    );
  }
}

class _Pages extends StatelessWidget {
  const _Pages({
    Key? key,
    required this.moviesProvider,
  }) : super(key: key);

  final MoviesProvider moviesProvider;

  @override
  Widget build(BuildContext context) {
    final navegacionModel = Provider.of<_NavegacionModel>(context);
    return PageView(
      controller: navegacionModel.pageController,
      physics: NeverScrollableScrollPhysics(),
      children: [
          SingleChildScrollView(
          child: Column(
            children: [
              MovieSlider(movies: moviesProvider.onDisplayMovies, title: 'En Cartelera'),
              MovieSlider(movies: moviesProvider.popularMovies, title: 'Populares'),
              MovieSlider(movies: moviesProvider.topRatedMovies, title: 'Mejor Calificados'),
            ],
          ),
        ),
        SingleChildScrollView(
          child: Center(child: Text('Hola 2'),),
        )
      ]
    );
  }
}

class _Navigation extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final navegacionModel = Provider.of<_NavegacionModel>(context);
    return BottomNavigationBar(
      currentIndex: navegacionModel.paginaActual ,
      onTap: (i) {
        navegacionModel.paginaActual = i;
      },
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.movie), label: 'Movies'),
        BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Saved'),
      // BottomNavigationBarItem(icon: Icon(Icons.star)),
    ]);
  }
}

class _NavegacionModel with ChangeNotifier{
  int _paginaActual = 0;
  PageController _pageController = new PageController();

  int get paginaActual => this._paginaActual;

  set paginaActual(int valor){
    this._paginaActual = valor;
    _pageController.animateToPage(valor, duration: Duration(milliseconds: 250), curve: Curves.easeOut);
    notifyListeners();
  }

  PageController get pageController => this._pageController;
}