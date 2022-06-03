import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:progra_movil/models/movie.dart';


class MovieService {
  static Future<Database> _openDB() async{
    return openDatabase(join(await getDatabasesPath(), 'movies.db'),
      onCreate: (db, version) {
        return db.execute("CREATE TABLE movies (id INTEGER PRIMARY KEY, poster_path varchar(40), backdrop_path varchar(40),title varchar(100), vote_average real, release_date varchar(100), overview text)");
      }, version: 1
    );
  }

  static Future<int> insert(Movie movie) async{
    Database database = await _openDB();
    return database.insert("movies", movie.toMap());
  }

  static Future<int> delete(Movie movie) async {
    Database database = await _openDB();
    return database.delete("movies", where: "id = ?", whereArgs: [movie.id]);
  }

  static Future<List<Movie>> movies() async {
    Database database = await _openDB();
    final List<Map<String, dynamic>> moviesMap = await database.query('movies');
    return moviesMap.map<Movie>((map) => Movie.fromMap(map)).toList();

    // return List.generate(moviesMap.length, (i) => Movie(
    //   id: moviesMap[i]['id'],
    //   posterPath: moviesMap[i]['poster_path'],
    //   backdropPath: moviesMap[i]['backdrop_path'],
    //   title: moviesMap[i]['title'],
    //   voteAverage: moviesMap[i]['vote_average'],
    //   releaseDate: moviesMap[i]['release_date'],
    //   overview: moviesMap[i]['overview']
    // ));
  }

  static Future<Movie?> findOne(int id) async{
    Database database = await _openDB();
    final res = await database.query('movies', where: 'id = ?', whereArgs: [id]);
    return res.isNotEmpty ? Movie.fromMap(res.first) : null;

    
  }

  static Future<bool> isFavourite(int id) async {
    final movie = await findOne(id);
    return movie != null;
  }

  static void toggleFovourite(Movie movie) async {
    final _movie = await findOne(movie.id);
    if (_movie != null)
      delete(movie);
    else
      insert(movie);
  }
}