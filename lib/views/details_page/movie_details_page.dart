import 'package:flutter/material.dart';
import 'package:the_movie/consts/api_consts.dart';
import 'package:the_movie/models/genres_model.dart';
import 'package:the_movie/models/movies_model.dart';
import 'package:the_movie/views/Widgets/button_genres/button_genres.dart';

class MovieDetailsPage extends StatefulWidget {
  final Movies movie;

  final String heroId;
  final List<Genres> genres;

  MovieDetailsPage(
      {Key? key,
      required this.movie,
      required this.heroId,
      required this.genres})
      : super(key: key);

  @override
  _MovieDetailsPageState createState() => _MovieDetailsPageState();
}

class _MovieDetailsPageState extends State<MovieDetailsPage> {
  final double imageDetailHeight = 220;
  final double imageCenteHeight = 100;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final top = imageDetailHeight - imageCenteHeight / 2;

    return Scaffold(
      appBar: AppBar(
        title: Text("Detalhes do Filme"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Column(
              children: <Widget>[
                Stack(
                  alignment: Alignment.center,
                  clipBehavior: Clip.none,
                  children: [
                    buildImageDetatils(),
                    Positioned(
                      top: top,
                      child: buildImageIconCenter(),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 50,
            ),
            titleMovie(),
            voteAverage(),
            buildBottonGenres(),
            Text(
              "Resumo",
              textAlign: TextAlign.start,
            ),
            overviewMovie()
          ],
        ),
      ),
    );
  }

  Widget buildImageDetatils() => Container(
        width: double.infinity,
        height: imageDetailHeight,
        child: Image.network(
          ApiConsts.tmdbBaseImageUrl + 'w500/' + widget.movie.backdropPath!,
          fit: BoxFit.cover,
        ),
      );

  Widget buildImageIconCenter() => CircleAvatar(
        radius: imageCenteHeight / 2,
        backgroundColor: Colors.transparent,
        child: Hero(
          tag: widget.heroId,
          child: SizedBox(
            width: 70,
            height: 90,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: widget.movie.posterPath == null
                  ? Image.asset(
                      'assets/images/loading.gif',
                      fit: BoxFit.cover,
                    )
                  : FadeInImage(
                      image: NetworkImage(ApiConsts.tmdbBaseImageUrl +
                          'w500/' +
                          widget.movie.posterPath!),
                      fit: BoxFit.cover,
                      placeholder: AssetImage('assets/images/loading.gif'),
                    ),
            ),
          ),
        ),
      );

  Widget titleMovie() => Container(
        child: Text(
          '${widget.movie.title}',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        ),
      );

  Widget voteAverage() => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '${widget.movie.voteAverage}',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            Icon(
              Icons.star,
              color: Colors.yellow,
            ),
          ],
        ),
      );

  Widget buildBottonGenres() => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: <Widget>[
                widget.genres.isEmpty
                    ? Container()
                    : GenreList(
                        genres: widget.movie.genreIds ?? [],
                        totalGenres: widget.genres,
                      ),
              ],
            ),
          ),
        ),
      );

  Widget overviewMovie() => Padding(
        padding: const EdgeInsets.fromLTRB(10.0, 8.0, 10.0, 20.0),
        child: Container(
          child: Text(
            '${widget.movie.overview}',
            textAlign: TextAlign.start,
          ),
        ),
      );
}
