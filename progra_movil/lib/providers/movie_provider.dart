import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:progra_movil/models/now_playing_response.dart';
import 'package:progra_movil/models/popular_responde.dart';
import 'package:progra_movil/models/top_rated_response.dart';
import 'package:progra_movil/models/trailer_response.dart';

import '../models/movie.dart';

class MoviesProvider extends ChangeNotifier {
  final String _apiKey = 'ceebb5d1f5ad811ecfc6c123e8dc6769';
  final String _baseUrl = 'api.themoviedb.org';
  final String _language = 'es-ES';

  List<Movie> onDisplayMovies = [];
  List<Movie> popularMovies = [];
  List<Movie> topRatedMovies = [];
  // String trailers = '';
  String trailers = '';

  MoviesProvider() {
    print('Provider inicializado');

    this.getOnDisplayMovies();
    this.getPopularMovies();
    this.getTopRatedMovies();
    // this.getTrailer(338953);
  }

  getOnDisplayMovies() async {
    final url = Uri.https(this._baseUrl, '3/movie/now_playing',
        {'api_key': _apiKey, 'language': _language, 'page': '1'});

    final response = await http.get(url);
    final nowPlayingResponse = NowPlayingResponse.fromJson(response.body);
    this.onDisplayMovies = nowPlayingResponse.results;
    notifyListeners();
  }

  getPopularMovies() async {
    final url = Uri.https(this._baseUrl, '3/movie/popular',
        {'api_key': _apiKey, 'language': _language, 'page': '1'});

    final response = await http.get(url);
    final popularResponse = PopularResponse.fromJson(response.body);
    this.popularMovies = [...popularMovies, ...popularResponse.results];
    notifyListeners();
  }

  getTopRatedMovies() async {
    final url = Uri.https(this._baseUrl, '3/movie/top_rated',
        {'api_key': _apiKey, 'language': _language, 'page': '1'});

    final response = await http.get(url);
    final topRatedResponse = TopRatedResponse.fromJson(response.body);
    this.topRatedMovies = [...popularMovies, ...topRatedResponse.results];
    notifyListeners();
  }

  getTrailer(int idMovie) async {
    // this.trailers = '';
    final url = Uri.https(this._baseUrl, '3/movie/$idMovie/videos',
        {'api_key': _apiKey, 'language': _language, 'page': '1'});

    final response = await http.get(url);
    final trailerResponse = jsonDecode(response.body);
    List youtube = trailerResponse['results'].where((video) => video ['site'] == 'YouTube').toList();
    this.trailers = youtube.isEmpty ? null : youtube.first['key'];
    // this.trailers.add(youtube.isEmpty ? '' : youtube.first['key']);
    // this.trailers.add(youtube.first['key'].toString());
    print(this.trailers);
    if(this.trailers.isEmpty){
      notifyListeners();
    }
    return true;
    // return youtube.isEmpty ? null : youtube.first['key'];
  }
}
