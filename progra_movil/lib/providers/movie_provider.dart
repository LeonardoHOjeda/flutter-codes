import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MoviesProvider extends ChangeNotifier {
  String _apiKey = 'ceebb5d1f5ad811ecfc6c123e8dc6769';
  String _baseUrl = 'api.themoviedb.org';
  String _language = 'es-ES';
  MoviesProvider() {
    print('Provider inicializado');

    this.getOnDisplayMovies();
  }

  getOnDisplayMovies() async {
    final url = Uri.https(this._baseUrl, '3/movie/now_playing',
        {'api_key': _apiKey, 'language': _language, 'page': '1'});

    final response = await http.get(url);
    print(response.body);
  }
}
