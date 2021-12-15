import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_movie/consts/api_consts.dart';
import 'package:the_movie/consts/api_endpoints.dart';
import 'package:the_movie/controllers/movies.controller.dart';
import 'package:the_movie/controllers/movies_favorite.controller.dart';
import 'package:the_movie/models/genres_model.dart';
import 'package:the_movie/models/movies_model.dart';
import '../details_page/movie_details_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Genres> _genres = [];
  List<Movies> moviesList = [];
  late MoviesFavorite favorites;
  List<Movies> selectedMovieFavorite = [];

  @override
  void initState() {
    fetchGenres().then((value) {
      _genres = value.genres ?? [];
    });

    getPopularMovies(Endpoints.popularMoviesUrl(1)).then((value) {
      setState(() {
        moviesList = value;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    favorites = context.watch<MoviesFavorite>();
    return Scaffold(
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 160,
          mainAxisSpacing: 5.0,
          childAspectRatio: 0.7,
        ),
        itemCount: moviesList.length,
        itemBuilder: (BuildContext context, int index) {
          bool isFavorite = Provider.of<MoviesFavorite>(context, listen: false)
              .listFavorites
              .contains(moviesList[index]);

          selectedMovieFavorite =
              Provider.of<MoviesFavorite>(context, listen: false)
                  .listFavorites
                  .toList();

          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MovieDetailsPage(
                      movie: moviesList[index],
                      genres: _genres,
                      heroId: '${moviesList[index].id}discover'),
                ),
              );
            },
            child: Hero(
              tag: '${moviesList[index].id}discover',
              child: Stack(
                children: [
                  FadeInImage(
                    image: NetworkImage(ApiConsts.tmdbBaseImageUrl +
                        'w500/' +
                        '${moviesList[index].posterPath}'),
                    fit: BoxFit.contain,
                    placeholder: AssetImage('assets/images/loading.gif'),
                  ),
                  Positioned(
                    top: 7,
                    right: 7,
                    child: GestureDetector(
                      onTap: () {
                        selectedMovieFavorite.add(moviesList[index]);

                        favorites.listFavorites.contains(moviesList[index])
                            ? Provider.of<MoviesFavorite>(context,
                                    listen: false)
                                .remove(moviesList[index])
                            : favorites.saveAll(selectedMovieFavorite);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: isFavorite
                              ? Color.fromRGBO(255, 255, 255, 0.6)
                              : Color.fromRGBO(0, 0, 0, 0.2),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Icon(
                            isFavorite
                                ? Icons.favorite
                                : Icons.favorite_border_outlined,
                            color: isFavorite ? Colors.red : Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
