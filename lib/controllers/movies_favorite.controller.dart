import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:the_movie/models/movies_model.dart';

class MoviesFavorite extends ChangeNotifier {
  List<Movies> _list = [];

  UnmodifiableListView<Movies> get listFavorites => UnmodifiableListView(_list);

  saveAll(List<Movies> movies) {
    movies.forEach((movie) {
      if (!_list.contains(movie)) _list.add(movie);
    });

    notifyListeners();
  }

  remove(Movies movie) {
    _list.remove(movie);
    notifyListeners();
  }
}
