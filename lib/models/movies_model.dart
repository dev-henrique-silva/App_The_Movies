class Movies {
  String? backdropPath;
  int? id;
  String? overview;
  double? popularity;
  String? posterPath;
  String? title;
  double? voteAverage;

  Movies({
    required this.backdropPath,
    required this.id,
    required this.overview,
    this.popularity,
    required this.posterPath,
    required this.title,
    required this.voteAverage,
  });
}
