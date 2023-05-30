import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../repository/shared_preferences.dart';

class MoviesList extends StatefulWidget {
  const MoviesList({super.key});

  @override
  State<StatefulWidget> createState() => _MoviesList();
}

class _MoviesList extends State<MoviesList> {
  SharedPref sharedPref = SharedPref();
  Set<String> movieName = {};
  Set<String> movieLoad = {};

  loadSharedPrefs() async {
    try {
      movieName = await sharedPref.read('getAll');
      setState(() {
        movieLoad = movieName;
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Minha Lista De Filmes'),
        centerTitle: true,
      ),
      backgroundColor: Colors.grey[850],
      body: ListView.builder(
        padding: const EdgeInsets.all(8.0),
        itemBuilder: (context, index) {
          if (index < movieName.length) {
            return Card(
              color: Colors.black,
              child: ListTile(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      flex: 19,
                      child: Text(
                        movieName.elementAt(index),
                        textAlign: TextAlign.left,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    // O Spacer dá um espaço entre o texto e o icone
                    Flexible(
                      flex: 1,
                        child: GestureDetector(
                          onTap: () {
                            sharedPref.remove(movieName.elementAt(index));
                            (ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content:
                                        Text("O filme foi removido da sua lista"),
                                    duration: Duration(milliseconds: 1500))));
                            loadSharedPrefs();
                          },
                          child: const Icon(
                            size: 22,
                            Icons.delete_forever,
                            color: Colors.red,
                          ),
                        ),
                      ),
                  ],
                ),
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
