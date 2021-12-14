import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:the_movie/controllers/movies_favorite.controller.dart';
import 'package:the_movie/models/movies_model.dart';
import 'package:provider/provider.dart';
import 'package:the_movie/views/details_page/movie_details_page.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({Key? key}) : super(key: key);

  @override
  _FavoritesPageState createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  List<Movies>? moviesList;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<MoviesFavorite>(
        builder: (context, favorites, child) {
          return favorites.listFavorites.isEmpty
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                      Icon(
                        Icons.favorite,
                        color: Colors.red,
                        size: 50,
                      ),
                      Text(
                        "Ainda não há filmes favoritos.",
                        style: TextStyle(fontSize: 18),
                        textAlign: TextAlign.center,
                      ),
                    ])
              : ListView.separated(
                  itemCount: favorites.listFavorites.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MovieDetailsPage(
                                movie: favorites.listFavorites[index],
                                heroId:
                                    '${favorites.listFavorites[index].id}discover'),
                          ),
                        );
                      },
                      child: ListTile(
                        leading: Hero(
                          tag: '${favorites.listFavorites[index].id}discover',
                          child: Image.network(
                              '${favorites.listFavorites[index].posterPath}'),
                        ),
                        title: Text(
                          '${favorites.listFavorites[index].title}',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          '${favorites.listFavorites[index].overview}',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 10),
                        ),
                        trailing: PopupMenuButton(
                          icon: Icon(
                            Icons.favorite,
                            color: Colors.red,
                          ),
                          itemBuilder: (context) => [
                            PopupMenuItem(
                                child: ListTile(
                                    title: Text("Remover dos favoritos"),
                                    onTap: () {
                                      Navigator.pop(context);
                                      Provider.of<MoviesFavorite>(context,
                                              listen: false)
                                          .remove(
                                              favorites.listFavorites[index]);
                                    })),
                          ],
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) =>
                      Divider(
                    color: Colors.black,
                  ),
                );
        },
      ),
    );
  }
}
