import 'package:flutter/material.dart';
import 'package:movies/repository/api_get_data.dart';
import 'package:movies/view/details_view.dart';
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

class HomeState extends ChangeNotifier {
  bool isLoading = false;

  void setLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<dynamic> updateResponse = [];
  final scrollController = ScrollController();
  var page = 1;
  static final homeRepository = HomeRepository();
  final homeState = HomeState();

  @override
  void initState() {
    super.initState();
    scrollController.addListener(_scrollListener);
    updateHome(page);
  }

  Future<void> updateHome(int page) async {
    homeState.setLoading(true);
    updateResponse.addAll(await homeRepository.fetch(page));
    setState(() {
      updateResponse;
      homeState.setLoading(false);
    });
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
                    color: Colors.deepOrange,
                    border: Border(
                      bottom: Divider.createBorderSide(
                        context,
                        color: Colors.grey[400],
                        width: 2.0,
                      ),
                    ),
                  ),
                  child: const Center(
                    child: Text(
                      'Filmes',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
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
        backgroundColor: Colors.grey[850],
        body: FutureBuilder<List>(
          initialData: updateResponse,
          //initialData: funciona para List, future: só aceita Future<List>
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
                itemCount: updateResponse.length + 1,
                itemBuilder: (context, index) {
                  if (index < updateResponse.length) {
                    final movie = snapshot.data![index];
                    final title = movie['title'];
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
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: Text(
                            overview,
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white),
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
                                img: img,
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  } else {
                    return const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }
                },
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ));
  }

  Future<void> _scrollListener() async {
    if (!homeState.isLoading &&
        (scrollController.position.pixels ==
            scrollController.position.maxScrollExtent)) {
      page++;
      await updateHome(page);
    }
  }
}

/*
Código antes de implementar o listener


import 'package:flutter/material.dart';
import 'package:movies/repository/api_get_data.dart';
import 'package:movies/view/details_view.dart';
import 'search_view.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<dynamic> updateResponse = [];
  final scrollController = ScrollController();
  var page = 1;
  static final homeRepository = HomeRepository();
  bool isLoading = false;

  Future updateHome(int page) async {
    isLoading = true;
    updateResponse.addAll(await homeRepository.fetch(page));
    setState(() {
      updateResponse;
      isLoading = false;
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
                  color: Colors.deepOrange,
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
      backgroundColor: Colors.grey[850],
      body: FutureBuilder<List>(
        initialData: updateResponse,
        //initialData: funciona para List, future: só aceita Future<List>
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
                  color: Colors.black,
                  child: ListTile(
                    title: Text(
                      '$title',
                      textAlign: TextAlign.center,
                      style:
                          const TextStyle(decoration: TextDecoration.underline,color: Colors.white),
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Text(
                        overview,
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white),
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
          } if(isLoading) {
            return const Center(
              child: CircularProgressIndicator(color: Colors.deepOrange),
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
    if ((scrollController.position.pixels ==
            (scrollController.position.maxScrollExtent) &&
        !isLoading)) {
      page = page + 1;
      await updateHome(page);
    }
  }
}
*/
