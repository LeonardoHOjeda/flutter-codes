import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:progra_movil/models/credits_response.dart';
import 'package:progra_movil/models/now_playing_response.dart';
import 'package:progra_movil/models/popular_responde.dart';
import 'package:progra_movil/models/top_rated_response.dart';
import 'package:progra_movil/models/trailer_response.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../models/movie.dart';

class MoviesProvider extends ChangeNotifier {
  // YoutubePlayerController ytController;
  final String _apiKey = 'ceebb5d1f5ad811ecfc6c123e8dc6769';
  final String _baseUrl = 'api.themoviedb.org';
  final String _language = 'es-ES';

  List<Movie> onDisplayMovies = [];
  List<Movie> popularMovies = [];
  List<Movie> topRatedMovies = [];
  Map<int, List<Cast>> moviesCast = {};
  // String trailers = '';
  String trailers = '';

  int _popularPage = 0;

  MoviesProvider() {
    print('Provider inicializado');

    this.getOnDisplayMovies();
    this.getPopularMovies();
    this.getTopRatedMovies();
    // this.getTrailer(338953);
  }

  Future<String> _getJsonData(String endpoint, [int page = 1]) async {
    var url = Uri.https(_baseUrl, endpoint,
        {'api_key': _apiKey, 'language': _language, 'page': '$page'});

    final response = await http.get(url);
    return response.body;
  }

  getOnDisplayMovies() async {
    final jsonData = await this._getJsonData('3/movie/now_playing');
    final nowPlayingResponse = NowPlayingResponse.fromJson(jsonData);
    this.onDisplayMovies = nowPlayingResponse.results;
    notifyListeners();
  }

  getPopularMovies() async {
    _popularPage++;
    final jsonData = await this._getJsonData('3/movie/popular');
    final popularResponse = PopularResponse.fromJson(jsonData);
    this.popularMovies = [...popularMovies, ...popularResponse.results];
    notifyListeners();
  }

  getTopRatedMovies() async {
    final jsonData = await this._getJsonData('3/movie/top_rated');
    final topRatedResponse = TopRatedResponse.fromJson(jsonData);
    this.topRatedMovies = [...popularMovies, ...topRatedResponse.results];
    notifyListeners();
  }

  getTrailer(int idMovie) async {
    final jsonData = await this._getJsonData('3/movie/$idMovie/videos');
    // this.trailers = '';
    final trailerResponse = jsonDecode(jsonData);
    List youtube = trailerResponse['results']
        .where((video) => video['site'] == 'YouTube')
        .toList();
    this.trailers = youtube.isEmpty ? '' : youtube.first['key'];
    // this.trailers.add(youtube.isEmpty ? '' : youtube.first['key']);
    // this.trailers.add(youtube.first['key'].toString());
    print(this.trailers);
    if (this.trailers.isEmpty) {
      notifyListeners();
    }
    return true;
    // return youtube.isEmpty ? null : youtube.first['key'];
  }

  // Future<bool> getTrailers(Movie movie) async {
  //   var moviesProvider;
  //   final movieId = await moviesProvider.getTrailer(movie.id);
  //   if (movieId == null) return false;
  //   ytController = YoutubePlayerController(
  //     initialVideoId: movieId,
  //     flags: YoutubePlayerFlags(autoPlay: true, mute: false, loop: false),
  //   );
  //   return true;
  // }

  Future<List<Cast>> getMovieCast(int movieId) async {
    if (moviesCast.containsKey(movieId)) return moviesCast[movieId]!;
    print('Prueba');
    final jsonData = await this._getJsonData('3/movie/$movieId/credits');
    final creditsResponse = CreditsResponse.fromJson(jsonData);

    moviesCast[movieId] = creditsResponse.cast;

    return creditsResponse.cast;
  }
}
