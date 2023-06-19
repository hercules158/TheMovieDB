import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movies/view/details_view.dart';

import '../repository/shared_preferences.dart';

class MoviesList extends StatefulWidget {
  const MoviesList({super.key});

  @override
  State<StatefulWidget> createState() => _MoviesList();
}

class MovieModel {
  //Above is the position in the List to each data we'll need
  static const title = 0;
  static const voteAverage = 1;
  static const movieId = 2;
  static const genre = 3;
  static const releaseDate = 4;
  static const overview = 5;
  static const img = 6;
}

class _MoviesList extends State<MoviesList> {
  SharedPref sharedPref = SharedPref();
  Set<dynamic> movieInfo = {};

  loadSharedPrefs() async {
    try {
      movieInfo = await sharedPref.read('getAll');
      setState(() {
        movieInfo;
      });
    } catch (exception) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Nothing found!"),
          duration: Duration(milliseconds: 500)));
    }
  }

  @override
  void initState() {
    super.initState();
    loadSharedPrefs();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Minha Lista De Filmes e Séries'),
        centerTitle: true,
      ),
      backgroundColor: Colors.grey[850],
      body: ListView.builder(
        padding: const EdgeInsets.all(8.0),
        itemBuilder: (context, index) {
          if (index < movieInfo.length) {
            return Card(
              color: Colors.black,
              child: ListTile(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                        flex: 20,
                        child: GestureDetector(
                          //Goes to DetailsPage when Tapped
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DetailsPage(
                                        title: movieInfo
                                            .elementAt(index)[MovieModel.title],
                                        voteAverage: movieInfo.elementAt(
                                            index)[MovieModel.voteAverage],
                                        movieId: movieInfo.elementAt(
                                            index)[MovieModel.movieId],
                                        genre: movieInfo
                                            .elementAt(index)[MovieModel.genre],
                                        releaseDate: movieInfo.elementAt(
                                            index)[MovieModel.releaseDate],
                                        overview: movieInfo.elementAt(
                                            index)[MovieModel.overview],
                                        img: movieInfo.elementAt(
                                            index)[MovieModel.img])));
                          },
                          child: Text(
                            movieInfo.elementAt(index)[0],
                            textScaleFactor: 1.2,
                            textAlign: TextAlign.left,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )),
                    // O Spacer dá um espaço entre o texto e o icone
                    Flexible(
                      flex: 1,
                      child: GestureDetector(
                        onTap: () {
                          sharedPref.remove(movieInfo.elementAt(index)[0]);
                          (ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text(
                                      "Filme ou série foi removido(a) da sua lista"),
                                  duration: Duration(milliseconds: 1500))));
                          loadSharedPrefs();
                        },
                        child: const Icon(
                          size: 25,
                          Icons.delete_forever,
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else if (movieInfo.isEmpty && index == 0) {
            return Padding(
              padding: EdgeInsets.only(top: height * 0.4),
              child: const Text(
                "Sem títulos em sua lista!",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white),
                textScaleFactor: 1.4,
              ),
            );
          } else {
            return null;
          }
        },
      ),
    );
  }
}
