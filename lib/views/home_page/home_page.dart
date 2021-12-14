import 'package:flutter/material.dart';
import 'package:the_movie/controllers/movies.controller.dart';
import '../details_page/movie_details_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final moviesList = ListMovies.movies;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("The Movie"),
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 5,
          crossAxisSpacing: 5,
          childAspectRatio: 0.7,
        ),
        itemCount: moviesList.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MovieDetailsPage(
                      movie: moviesList[index],
                      heroId: '${moviesList[index].id}discover'),
                ),
              );
            },
            child: Hero(
              tag: '${moviesList[index].id}discover',
              child: Stack(
                children: [
                  FadeInImage(
                    image: AssetImage('${moviesList[index].posterPath}'),
                    fit: BoxFit.fill,
                    placeholder: AssetImage('assets/images/loading.gif'),
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
