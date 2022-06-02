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
    Future<dynamic> _movieId() async{
      final String mID = await moviesProvider.getTrailer(movie.id);
      print(mID);
      return mID;
    } 
    print("Movie: ${_movieId()}");


    YoutubePlayerController _controller = YoutubePlayerController(
    initialVideoId: 'oImEeiCiYTk',
    flags: YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
        loop: false
      ),
    );

    // print("Movie: ${movie}");

    return Scaffold(
      appBar: AppBar(
        title: Text('Trailer'),
        backgroundColor: Colors.pink,
      ),
      // backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            YoutubePlayer(
              controller: _controller,
              showVideoProgressIndicator: true,
              progressColors: ProgressBarColors(
                playedColor: Colors.amber,
                handleColor: Colors.amberAccent
              ),
            )
          ],
        ),
      )
    );
  }
}