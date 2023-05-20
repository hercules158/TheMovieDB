import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class PopularGenreMovies extends StatefulWidget {
  final int genre;
  const PopularGenreMovies({super.key, required this.genre});

  @override
  State<StatefulWidget> createState() => _PopularGenreMovies(genreCode: genre);

}
class _PopularGenreMovies extends State<PopularGenreMovies> {
  final int genreCode;
  _PopularGenreMovies({required this.genreCode});
  String genre = "";

  genreTable(){
    print(genreCode);
    switch (genreCode) {
      case 28:
        {
          genre = "Ação";
          print("Ação");
        }
        break;
      default:
        {
          genre = "Ficção Ciêntífica";
        }
    }
    return genre;
  }

  @override
  void initState() {
    super.initState();
    genreTable();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Filmes de $genre'),
        centerTitle: true,
      ),
    );
  }
}
