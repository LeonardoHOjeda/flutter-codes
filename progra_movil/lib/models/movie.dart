class Movie {
    Movie({
        required this.backdropPath,
        required this.id,
        this.originalTitle,
        required this.overview,
        required this.posterPath,
        required this.releaseDate,
        required this.title,
        required this.voteAverage,
        required this.voteCount,
    });

    get fullPosterImg{
      if(this.posterPath != null){
        return 'https://image.tmdb.org/t/p/w500${this.posterPath}';
      } else {
        return 'https://i.stack.imgur.com/GNhxO.png';
      }
    }

    get fullBackdropPath{
      if(this.posterPath != null){
        return 'https://image.tmdb.org/t/p/w500${this.backdropPath}';
      } else {
        return 'https://i.stack.imgur.com/GNhxO.png';
      }
    }

    String backdropPath;
    int id;
    String? originalTitle;
    String overview;
    String posterPath;
    DateTime releaseDate;
    String title;
    double voteAverage;
    int voteCount;
    String? heroId;

    factory Movie.fromMap(Map<String, dynamic> json) => Movie(
        backdropPath: json["backdrop_path"],
        id: json["id"],
        // originalTitle: json["original_title"],
        overview: json["overview"],
        posterPath: json["poster_path"],
        releaseDate: DateTime.parse(json["release_date"]),
        title: json["title"],
        voteAverage: json["vote_average"].toDouble(),
        voteCount: json["vote_count"],
    );
    // factory Movie.fromMap(Map<String, dynamic> json) => Movie(
    //     adult: json["adult"],
    //     backdropPath: json["backdrop_path"],
    //     genreIds: List<int>.from(json["genre_ids"].map((x) => x)),
    //     id: json["id"],
    //     originalLanguage: json["original_language"],
    //     originalTitle: json["original_title"],
    //     overview: json["overview"],
    //     popularity: json["popularity"].toDouble(),
    //     posterPath: json["poster_path"],
    //     releaseDate: DateTime.parse(json["release_date"]),
    //     title: json["title"],
    //     video: json["video"],
    //     voteAverage: json["vote_average"].toDouble(),
    //     voteCount: json["vote_count"],
    // );

    Map<String, dynamic> toMap() => {
      "backdrop_path": backdropPath,
      "id": id,
      "original_title": originalTitle,
      "overview": overview,
      "poster_path": posterPath,
      "release_date": releaseDate.toString(),
      "title": title,
      // "video": video,
      "vote_average": voteAverage,
    };
}