import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import 'package:progra_movil/models/movie.dart';
import 'package:progra_movil/providers/movie_provider.dart';
import 'package:progra_movil/screens/trailer_screen.dart';
import 'package:progra_movil/widgets/save_button.dart';
import 'package:progra_movil/widgets/widgets.dart';
import 'package:provider/provider.dart';
import 'package:favorite_button/favorite_button.dart';



class DetailsMovieScreen extends StatelessWidget {

  static const String routerName = 'DetailsMovie';

  @override
  Widget build(BuildContext context) {

    final moviesProvider = Provider.of<MoviesProvider>(context);
    final Movie movie = ModalRoute.of(context)!.settings.arguments as Movie;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _CustomAppBar(movie: movie,),
          SliverList(
            delegate: SliverChildListDelegate([
              _PosterAndTitle(movie: movie,),
              _Description(movie: movie,),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: ElevatedButton.icon(
                  onPressed: (){
                    Navigator.pushNamed(context, TrailerScreen.routerName, arguments: movie);
                    print('Ver trailer');
                  },
                  icon: Icon(Icons.ondemand_video),
                  label: Text('Ver trailer'),
                ),
              ),
              CastingCards(movieId: movie.id),
            ])
          )
        ],
      )
    );
  }
}

class _Description extends StatelessWidget {

  final Movie movie;

  const _Description({required this.movie});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: Text(movie.overview, textAlign: TextAlign.justify)
    );
  }
}

class _CustomAppBar extends StatelessWidget {

  final Movie movie;

  const _CustomAppBar({required this.movie});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Colors.green[800],
      expandedHeight: 200,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: EdgeInsets.all(0),
        centerTitle: true,
        title: Container(
          color: Colors.black12,
          child: Text(movie.title, style: TextStyle(fontSize: 16), textAlign: TextAlign.center,),
          padding: EdgeInsets.only(bottom: 10, left: 10, right: 10),
          width: double.infinity,
          alignment: Alignment.bottomCenter,
        ),
        background: FadeInImage(
          placeholder: AssetImage('assets/no-image.jpeg'),
          image: NetworkImage(movie.fullBackdropPath),
          fit: BoxFit.cover,
        ),
      ),

    );
  }
}


class _PosterAndTitle extends StatelessWidget {

  final Movie movie;

  const _PosterAndTitle({required this.movie});

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;


    return Container(
      margin: EdgeInsets.only(top: 20),
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Hero(
            tag: movie.heroId!,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: FadeInImage(
                placeholder: AssetImage('assets/no-image.jpeg'),
                image: NetworkImage(movie.fullPosterImg),
                height: 150,
              ),
            ),
          ),
          SizedBox(width: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ConstrainedBox(
                constraints: BoxConstraints(maxWidth: size.width - 190),
                child: (movie.originalTitle != null)
                ? Text(movie.originalTitle!, style: textTheme.headline5, overflow: TextOverflow.ellipsis, maxLines: 2)
                : Text('No Title', style: textTheme.headline5, overflow: TextOverflow.ellipsis, maxLines: 2)
              ),
              
              Text(movie.releaseDate.toString(), style: textTheme.subtitle1, overflow: TextOverflow.ellipsis, maxLines: 1),
              Row(
                children: [
                  Icon(Icons.heart_broken),
                  SizedBox(width: 5),
                  Text('${movie.voteAverage}/10 - ${movie.voteCount} votos')
                ],
              ),
              // Container(
              //   child: SaveButton(movie: movie)
              // )
            ],
          )

        ],
      ),
    );
  }
}