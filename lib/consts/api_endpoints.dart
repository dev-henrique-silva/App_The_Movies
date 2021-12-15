import 'api_consts.dart';

class Endpoints {
  static String popularMoviesUrl(int page) {
    return '${ApiConsts.tmdbApiBaseUrl}'
        '/movie/popular?api_key='
        '${ApiConsts.tmdbApiKey}'
        '&include_adult=false&page=$page';
  }

  static String movieDetailsUrl(int movieId) {
    return '${ApiConsts.tmdbApiBaseUrl}/movie/$movieId?api_key=${ApiConsts.tmdbApiKey}&append_to_response=credits,'
        'images';
  }

  static String movieSearchUrl(String query) {
    return '${ApiConsts.tmdbApiBaseUrl}/search/movie?query=$query&api_key=${ApiConsts.tmdbApiKey}';
  }

  static String genresUrl() {
    return '${ApiConsts.tmdbApiBaseUrl}/genre/movie/list?api_key=${ApiConsts.tmdbApiKey}&language=en-US';
  }

  static String getMoviesForGenre(int genreId, int page) {
    return '${ApiConsts.tmdbApiBaseUrl}/discover/movie?api_key=${ApiConsts.tmdbApiKey}'
        '&language=en-US'
        '&sort_by=popularity.desc'
        '&include_adult=false'
        '&include_video=false'
        '&page=$page'
        '&with_genres=$genreId';
  }
}
