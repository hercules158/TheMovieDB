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
                border: OutlineInputBorder(),
                labelText: 'Pesquisar',
                prefixIcon: Icon(Icons.search),
              ),
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

                      return Container(
                        decoration: const BoxDecoration(
                            border: Border(
                                bottom: BorderSide(color: Colors.indigo))),
                        child: ListTile(
                          title: Text(
                            '$title',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                decoration: TextDecoration.underline),
                          ),
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
                      );
                    },
                  );
                }
                if (!snapshot.hasData) {
                  return const Center(child: Text('Pesquise um filme'));
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
