import 'package:flutter/material.dart';
import 'package:movies/repository/api_get_data.dart';
import 'details_view.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<StatefulWidget> createState() => _SearchPage();
}

class _SearchPage extends State<SearchPage> {
  final myController = TextEditingController();

  dynamic searchResponse;

  _updateSearch(val) {
    setState(() {
      searchResponse = HomeRepository().fetchByName(val);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pesquisar Filmes'),
        centerTitle: true,
      ),
      backgroundColor: Colors.grey[850],
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextFormField(
              onChanged: (value) {
                _updateSearch(value);
              },
              decoration: const InputDecoration(
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white)),
                counterStyle: TextStyle(color: Colors.white),
                border: OutlineInputBorder(),
                labelText: 'Pesquisar',
                labelStyle: TextStyle(color: Colors.white),
                prefixIcon: Icon(Icons.search, color: Colors.white),
              ),
              style: const TextStyle(color: Colors.white),
            ),
          ),
          Expanded(
            child: FutureBuilder<List>(
              future: searchResponse,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return const Center(
                    child: Text('Erro ao carregar dados'),
                  );
                }

                if (snapshot.hasData) {
                  return ListView.builder(
                    padding: EdgeInsets.all(8.0),
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
                        color: Colors.black,
                        child: ListTile(
                          title: Text(
                            '$title',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                decoration: TextDecoration.underline,
                                color: Colors.white),
                          ),
                          subtitle: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              overview,
                              textAlign: TextAlign.center,
                              style: const TextStyle(color: Colors.white),
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
                }
                if (!snapshot.hasData) {
                  return const Center(
                      child: Text(
                    'Pesquise um filme',
                    style: TextStyle(color: Colors.white),
                  ));
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

/*
TextFormField(
          onChanged: (value) {
            _updateSearch(value);
          },
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Pesquisar',
            prefixIcon: Icon(Icons.search),
          ),
        ),
*/
