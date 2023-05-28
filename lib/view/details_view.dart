import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:movies/repository/shared_preferences.dart';

class DetailsPage extends StatefulWidget {
  final dynamic overview;
  final String releaseDate;
  final String title;
  final dynamic voteAverage;
  final String img;

  const DetailsPage(
      {super.key,
      required this.title,
      required this.overview,
      required this.releaseDate,
      required this.voteAverage,
      required this.img});

  @override
  State<StatefulWidget> createState() => _DetailsPage();
}

class _DetailsPage extends State<DetailsPage> {
  SharedPref sharedPref = SharedPref();
  IconData listIcon = Icons.playlist_add_circle;
  var movieName;
  var movieLoad;

  @override
  void initState() {
    super.initState();
    loadSharedPrefs();
  }

  loadSharedPrefs() async {
    try {
      movieName = await sharedPref.read(widget.title);
      setState(() {
        movieLoad = movieName;
      });

      if (movieLoad != widget.title) {
        setState(() {
          listIcon = Icons.playlist_add_circle;
        });
      } else {
        setState(() {
          listIcon = Icons.playlist_add_check_circle_rounded;
        });
      }

    } catch (Exception) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Nothing found!"),
          duration: Duration(milliseconds: 500)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white12,
      appBar: AppBar(
        title: const Text('Detalhes do filme'),
        centerTitle: true,
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: GestureDetector(
                onTap: () {
                  //Lógica para mudar o desenho do ícone
                    if (movieLoad != widget.title) {
                      sharedPref.save(widget.title, widget.title);
                      (ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text("Adicionado à sua lista"),
                          duration: Duration(milliseconds: 1000))));
                      loadSharedPrefs();
                    } else {
                      sharedPref.remove(widget.title);
                      (ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text("Removido da sua lista"),
                          duration: Duration(milliseconds: 1000))));
                      loadSharedPrefs();
                    }
                },
                child: Icon(size: 35, listIcon)),
          ),
        ],
      ),
      body: ListView(
        children: [
          Column(
            children: [
              const Padding(padding: EdgeInsets.all(0.0)),
              Image.network(widget.img),
              Column(
                children: [
                  const Padding(padding: EdgeInsets.all(8.0)),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      widget.title,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
              Column(children: [
                const Padding(padding: EdgeInsets.all(8.0)),
                Text(
                  DateFormat('dd-MM-yyyy')
                      .format(DateTime.parse(widget.releaseDate)),
                  style: const TextStyle(color: Colors.white),
                ),
              ]),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    title: Text(
                      widget.overview,
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
              ListTile(
                title: Text(
                  'Nota Média: ${widget.voteAverage}',
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
