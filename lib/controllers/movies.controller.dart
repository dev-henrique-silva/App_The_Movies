import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:the_movie/consts/api_endpoints.dart';
import 'package:the_movie/models/genres_model.dart';
import 'package:the_movie/models/movies_model.dart';

Future<List<Movies>> getPopularMovies(String api) async {
  try {
    MoviesResponse movieList;
    var res = await http.get(Uri.parse(api));
    var decodeRes = jsonDecode(res.body);
    movieList = MoviesResponse.fromJson(decodeRes);
    return movieList.movies ?? [];
  } catch (e) {
    throw Exception("Não foi possível carregar os dados!");
  }
}

Future<GenresList> fetchGenres() async {
  GenresList genresList;
  var res = await http.get(Uri.parse(Endpoints.genresUrl()));
  var decodeRes = jsonDecode(res.body);
  genresList = GenresList.fromJson(decodeRes);
  return genresList;
}
