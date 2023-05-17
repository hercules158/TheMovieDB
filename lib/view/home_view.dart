import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:movies/const/base_url.dart';
import 'package:movies/repository/api_get_data.dart';
import 'package:movies/view/details_view.dart';
import 'package:http/http.dart' as http;

import 'search_view.dart';

class Results {
  final List results;

  Results({required this.results});
}

class Movie {
  final String title;
  final String overview;

  Movie({required this.title, required this.overview});
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<List<dynamic>> updateResponse = HomeRepository().fetch(1);
  final scrollController = ScrollController();
  var page = 1;

  Future updateHome(int pages) async {
    updateResponse = HomeRepository().fetch(pages);
    setState(() {
      updateResponse;
    });
  }

  @override
  void initState() {
    super.initState();
    scrollController.addListener(_scrollListener);
    updateHome(page);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Filmes Populares'),
        centerTitle: true,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            SizedBox(
              height: 95.0,
              child: DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.black87,
                  border: Border(
                    bottom: Divider.createBorderSide(context,
                        color: Colors.grey[400], width: 2.0),
                  ),
                ),
                child: const Center(
                    child: Text(
                  'Filmes',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white),
                )),
              ),
            ),
            ListTile(
              title: const Text('Filmes Populares'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const HomePage()),
                );
              },
            ),
            ListTile(
              title: const Text('Pesquisar'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SearchPage()),
                );
              },
            ),
          ],
        ),
      ),
      backgroundColor: Colors.grey[200],
      body: FutureBuilder<List>(
        future: updateResponse,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text('Erro ao carregar dados'),
            );
          }
          if (snapshot.hasData) {
            return ListView.builder(
              padding: const EdgeInsets.all(8.0),
              controller: scrollController,
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final movie = snapshot.data![index];
                final title = movie['title'];
                //Teste com operador ternário para saber se temos ou não uma descrição
                final overview = movie['overview'] == ''
                    ? 'Descrição indisponível'
                    : snapshot.data![index]['overview'];
                final releaseDate = movie['release_date'];
                final voteAverage = movie['vote_average'];
                final img =
                    'https://image.tmdb.org/t/p/w400${movie['poster_path']}';

                return Card(
                  child: ListTile(
                    title: Text(
                      '$title',
                      textAlign: TextAlign.center,
                      style:
                          const TextStyle(decoration: TextDecoration.underline),
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Text(
                        overview,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DetailsPage(
                                title: title,
                                overview: overview,
                                releaseDate: releaseDate,
                                voteAverage: voteAverage,
                                img: img)),
                      );
                    },
                  ),
                );
              },
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  Future<void> _scrollListener() async {
    if (scrollController.position.pixels ==
        (scrollController.position.maxScrollExtent)) {
      page = page + 1;
      await updateHome(page);
    }
  }
}
