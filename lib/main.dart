import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_movie/controllers/movies_favorite.controller.dart';
import 'package:the_movie/views/favorites_page/favorites_page.dart';
import 'package:the_movie/views/home_page/home_page.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => MoviesFavorite(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.red),
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: Text("The Movie"),
            centerTitle: true,
            bottom: TabBar(
              tabs: [
                Tab(text: 'Home', icon: Icon(Icons.home)),
                Tab(text: 'Favoritos', icon: Icon(Icons.favorite)),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              HomePage(),
              FavoritesPage(),
            ],
          ),
        ),
      ),
    );
  }
}
