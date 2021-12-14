import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_movie/controllers/movies.controller.dart';
import 'package:the_movie/controllers/movies_favorite.controller.dart';
import 'package:the_movie/models/movies_model.dart';
import '../details_page/movie_details_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final moviesList = ListMovies.movies;
  late MoviesFavorite favorites;
  List<Movies> selectedMovieFavorite = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    favorites = context.watch<MoviesFavorite>();
    return Scaffold(
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 5,
          crossAxisSpacing: 5,
          childAspectRatio: 0.7,
        ),
        itemCount: moviesList.length,
        itemBuilder: (BuildContext context, int index) {
          bool isFavorite = favorites.listFavorites.contains(moviesList[index]);
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
                        heroId: '${moviesList[index].id}discover'),
                  ));
            },
            child: Hero(
              tag: '${moviesList[index].id}discover',
              child: Stack(
                children: [
                  FadeInImage(
                    image: NetworkImage('${moviesList[index].posterPath}'),
                    fit: BoxFit.cover,
                    placeholder: AssetImage('assets/images/loading.gif'),
                  ),
                  Positioned(
                    top: 1,
                    right: 1,
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
                          padding: const EdgeInsets.all(6.0),
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
