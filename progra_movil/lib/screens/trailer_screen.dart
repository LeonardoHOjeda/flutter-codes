import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:progra_movil/models/movie.dart';
import 'package:provider/provider.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../providers/movie_provider.dart';

class TrailerScreen extends StatelessWidget {

  static const String routerName = 'Trailer';
  
  @override
  Widget build(BuildContext context) {
    
    final moviesProvider = Provider.of<MoviesProvider>(context);
    final Movie movie = ModalRoute.of(context)!.settings.arguments as Movie;
    moviesProvider.getTrailer(movie.id);

    print(moviesProvider.trailers);

    TrailerScreen(){
      moviesProvider.getTrailer(movie.id);
    }

      return Scaffold(
        appBar: AppBar(
        title: Text('Trailer'),
        backgroundColor: Colors.pink,
      ),
      // backgroundColor: Colors.black,
      body: (moviesProvider.trailers.isEmpty)
          ? Center(child: CircularProgressIndicator())
          : YoutubePlayer(
            controller: YoutubePlayerController(
              initialVideoId: moviesProvider.trailers,
              flags: YoutubePlayerFlags(
                autoPlay: true,
                mute: false,
                loop: false
              ),
            ),
            showVideoProgressIndicator: true,
            progressColors: ProgressBarColors(
              playedColor: Colors.green,
              handleColor: Colors.greenAccent
            ),
          )
      
      
      // FutureBuilder(
      //   future: moviesProvider.getTrailer(movie.id),
      //   builder: (_, AsyncSnapshot<bool> snapshot){
      //     if(!snapshot.hasData){
      //       return Center(child: CircularProgressIndicator());
      //     }
      //     if(!snapshot.data!){
      //       return Center(child: Text('No trailer'));
      //     }
      //     return YoutubePlayer(
      //       controller: YoutubePlayerController(
      //         initialVideoId: movie.id.toString(),
      //         flags: YoutubePlayerFlags(autoPlay: true, mute: false, loop: false),
      //       ),
      //       showVideoProgressIndicator: true,
      //       progressColors: ProgressBarColors(
      //         playedColor: Colors.green,
      //         handleColor: Colors.greenAccent
      //       ),
      //     );
      //   },
      // )
    );
  }
}