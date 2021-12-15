class Movies {
  Movies({
    required this.id,
    required this.backdropPath,
    required this.genreIds,
    required this.overview,
    required this.posterPath,
    required this.title,
    required this.voteAverage,
  });

  int? id;
  String? backdropPath;
  List<int>? genreIds;
  String? overview;
  String? posterPath;
  String? title;
  double? voteAverage;

  Movies.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    backdropPath = json["backdrop_path"];
    genreIds = json['genre_ids'].cast<int>();
    overview = json["overview"];
    posterPath = json["poster_path"];
    title = json["title"];
    voteAverage = json["vote_average"].toDouble();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['id'] = this.id;
    data['backdrop_path'] = this.backdropPath;
    data['genre_ids'] = this.genreIds;
    data['overview'] = this.overview;
    data['poster_path'] = this.posterPath;
    data['title'] = this.title;
    data['vote_average'] = this.voteAverage;

    return data;
  }
}

class Genre {
  Genre({
    required this.id,
    required this.name,
  });

  final int id;
  final String name;

  factory Genre.fromJson(Map<String, dynamic> json) => Genre(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}

class MoviesResponse {
  int? page;
  List<Movies>? movies;

  MoviesResponse({
    required this.page,
    required this.movies,
  });

  MoviesResponse.fromJson(Map<String, dynamic> json) {
    try {
      page = json['page'];
      if (json['results'] != null) {
        movies = <Movies>[];
        json['results'].forEach((v) {
          movies!.add(new Movies.fromJson(v));
        });
      }
    } catch (error) {
      print("Error is $error");
    }
  }
}
