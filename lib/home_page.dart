import 'package:flutter/material.dart';
import 'package:movies/details_page.dart';
import 'package:movies/api_get_data.dart';
import 'package:movies/search_page.dart';

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
  var updateResponse;

  updateHome() {
    setState(() {
      updateResponse = RequestAPI().fetch();
    });
  }

  @override
  Widget build(BuildContext context) {
    updateHome();

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
      backgroundColor: Colors.white,
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
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                var title = snapshot.data![index]['title'];
                //Teste com operador ternário para saber se temos ou não uma descrição
                var overview = snapshot.data![index]['overview'] == ''
                    ? 'Descrição indisponível'
                    : snapshot.data![index]['overview'];
                var releaseDate = snapshot.data![index]['release_date'];
                var voteAverage = snapshot.data![index]['vote_average'];
                var img =
                    'https://image.tmdb.org/t/p/w300${snapshot.data![index]['poster_path']}';

                return Column(
                  children: [
                    Column(
                      children: [
                        const Padding(padding: EdgeInsets.all(4.0)),
                        ListTile(
                          title: Text('$title', textAlign: TextAlign.center),
                          subtitle: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(overview, textAlign: TextAlign.center),
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
                      ],
                    ),
                  ],
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
}
