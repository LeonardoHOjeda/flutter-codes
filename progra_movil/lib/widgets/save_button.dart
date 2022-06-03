import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:like_button/like_button.dart';
import 'package:progra_movil/models/movie.dart';
import 'package:progra_movil/services/movie_service.dart';

class SaveButton extends StatelessWidget {
  final Movie movie;

  const SaveButton({required this.movie});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: MovieService.isFavourite(movie.id),
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot){
        if(!snapshot.hasData) return Container();
        return FavoriteButton(
          iconSize: 40,
          isFavorite: snapshot.data,
          valueChanged: (_isFavorite){
            MovieService.toggleFovourite(movie);
          }
        );
        // return LikeButton(
        //   size: 40,
        //   isLiked: snapshot.data,
        //   onTap: (isLiked){
            
        //   }
        // );
      }
    );
  }
}