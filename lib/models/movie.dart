import 'dart:convert';

class Movie {

  Movie({
    required this.adult,
    this.backdropPath,
    required this.genreIds,
    required this.id,
    required this.originalLanguage,
    required this.originalTitle,
    required this.overview,
    required this.popularity,
    this.posterPath,
    required this.releaseDate,
    required this.title,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
  });

  bool adult;
  String? backdropPath;
  List<int> genreIds;
  int id;
  String originalLanguage;
  String originalTitle;
  String overview;
  String popularity;
  String? posterPath;
  String? releaseDate;
  String title;
  bool video;
  String voteAverage;
  int voteCount;

  //To identify element for hero animation
  String? heroId;

  get fullPosterPath {
    if(this.posterPath != null) {
      return 'https://image.tmdb.org/t/p/w500${this.posterPath}';
    }else if(this.posterPath == null || this.posterPath!.isEmpty) {
      return 'https://ecowaterqa.vtexassets.com/arquivos/ids/156134-800-auto?width=800&height=auto&aspect=true';
    }
  }

  get fullBackdropPath {
    if(this.backdropPath != null) {
      return 'https://image.tmdb.org/t/p/w500${this.backdropPath}';
    }else if(this.backdropPath == null || this.backdropPath!.isEmpty) {
      return 'https://ecowaterqa.vtexassets.com/arquivos/ids/156134-800-auto?width=800&height=auto&aspect=true';
    }
  }

  factory Movie.fromJson(String str) => Movie.fromMap(json.decode(str));

  //String toJson() => json.encode(toMap());

  factory Movie.fromMap(Map<String, dynamic> json) => Movie(
    adult       : json["adult"],
    backdropPath: json["backdrop_path"] == null ? null : json["backdrop_path"],
    genreIds    : List<int>.from(json["genre_ids"].map((x) => x)),
    id          : json["id"],
    originalLanguage: json["original_language"],
    originalTitle   : json["original_title"],
    overview   : json["overview"],
    popularity : json["popularity"].toString(),
    posterPath : json["poster_path"] == null ? null : json["poster_path"],
    releaseDate: json["release_date"],
    title      : json["title"],
    video      : json["video"],
    voteAverage: json["vote_average"].toString(),
    voteCount  : json["vote_count"],
  );
  
  /* Map<String, dynamic> toMap() => {
    "adult": adult,
    "backdrop_path": backdropPath == null ? null : backdropPath,
    "genre_ids": List<dynamic>.from(genreIds.map((x) => x)),
    "id": id,
    "original_language": originalLanguage,
    "original_title": originalTitle,
    "overview": overview,
    "popularity": popularity,
    "poster_path": posterPath == null ? null : posterPath,
    "release_date": "${releaseDate.year.toString().padLeft(4, '0')}-${releaseDate.month.toString().padLeft(2, '0')}-${releaseDate.day.toString().padLeft(2, '0')}",
    "title": title,
    "video": video,
    "vote_average": voteAverage,
    "vote_count": voteCount,
  }; */
}
