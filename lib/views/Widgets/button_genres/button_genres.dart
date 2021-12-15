import 'package:flutter/material.dart';
import 'package:the_movie/models/genres_model.dart';

class GenreList extends StatefulWidget {
  final List<int> genres;
  final List<Genres> totalGenres;
  GenreList({required this.genres, required this.totalGenres});

  @override
  _GenreListState createState() => _GenreListState();
}

class _GenreListState extends State<GenreList> {
  List<Genres>? _genres;
  @override
  void initState() {
    super.initState();
    _genres = [];
    Future.delayed(Duration.zero, () {
      widget.totalGenres.forEach((valueGenre) {
        widget.genres.forEach((genre) {
          if (valueGenre.id == genre) {
            _genres?.add(valueGenre);
            setState(() {});
          }
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: Center(
        child: _genres == null
            ? CircularProgressIndicator()
            : ListView.builder(
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemCount: _genres!.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: InkWell(
                      onTap: () {},
                      child: Chip(
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                            width: 1,
                            style: BorderStyle.solid,
                          ),
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        label: Text(
                          _genres![index].name!,
                        ),
                        backgroundColor: Colors.transparent,
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
