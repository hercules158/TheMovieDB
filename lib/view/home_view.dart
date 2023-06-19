import 'package:flutter/material.dart';
import 'package:movies/repository/api_get_data.dart';
import 'package:movies/view/details_view.dart';
import 'package:movies/view/movie_list.dart';
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
  final int genreCode;

  const HomePage({super.key, required this.genreCode});

  @override
  State<StatefulWidget> createState() => _HomePageState(genreCode: genreCode);
}

class _HomePageState extends State<HomePage> {
  List<dynamic> updateResponse = [];
  final scrollController = ScrollController();
  var page = 1;
  static final homeRepository = HomeRepository();
  final homeState = HomeState();
  final int genreCode;

  _HomePageState({required this.genreCode});

  String genreOrId = "";

  genreTable() {
    switch (genreCode) {
      case 12:
        {
          genreOrId = "Filmes de Aventura";
        }
        break;
      case 14:
        {
          genreOrId = "Filmes de Fantasia";
        }
        break;
      case 16:
        {
          genreOrId = "Filmes de Animação";
        }
        break;
      case 18:
        {
          genreOrId = "Filmes de Drama";
        }
        break;
      case 27:
        {
          genreOrId = "Filmes de Horror";
        }
        break;
      case 28:
        {
          genreOrId = "Filmes de Ação";
        }
        break;
      case 35:
        {
          genreOrId = "Filmes de Comédia";
        }
        break;
      case 36:
        {
          genreOrId = "Filmes de História";
        }
        break;
      case 37:
        {
          genreOrId = "Filmes de Faroeste";
        }
        break;
      case 53:
        {
          genreOrId = "Filmes Thriller";
        }
        break;
      case 69:
        {
          genreOrId = "Tendências da Última Semana";
        }
        break;
      case 80:
        {
          genreOrId = "Filmes de Crime";
        }
        break;
      case 99:
        {
          genreOrId = "Documentários";
        }
        break;
      case 878:
        {
          genreOrId = "Filmes Ficção Científica";
        }
        break;
      case 9648:
        {
          genreOrId = "Filmes de Mistério";
        }
        break;
      case 10402:
        {
          genreOrId = "Filmes Musicais";
        }
        break;
      case 10749:
        {
          genreOrId = "Filmes de Romance";
        }
        break;
      case 10751:
        {
          genreOrId = "Filmes para Família";
        }
        break;
      case 10752:
        {
          genreOrId = "Filmes de Guerra";
        }
        break;
      case 10762:
        {
          genreOrId = "Infantil";
        }
        break;
      case 10763:
        {
          genreOrId = "Notícias";
        }
        break;
      case 10764:
        {
          genreOrId = "Reality";
        }
        break;
      case 10766:
        {
          genreOrId = "Novelas";
        }
        break;
      case 10767:
        {
          genreOrId = "Entrevista";
        }
        break;
      case 10768:
        {
          genreOrId = "Guerra e Política";
        }
        break;
      case 10770:
        {
          genreOrId = "Filmes de Séries";
        }
        break;
      default:
        {
          genreOrId = "Filmes e Séries em Alta";
        }
    }
    return genreOrId;
  }

  @override
  void initState() {
    super.initState();
    scrollController.addListener(_scrollListener);
    genreTable();
    updateHome(page, genreCode);
  }

  Future<void> updateHome(int page, int genreCode) async {
    homeState.setLoading(true);
    updateResponse.addAll(await homeRepository.fetch(page, genreCode));
    setState(() {
      updateResponse;
      homeState.setLoading(false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(genreOrId),
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
                title: const Text('Filmes e Séries em Alta'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const HomePage(
                              genreCode: 0,
                            )),
                  );
                },
              ),
              ListTile(
                title: const Text(
                    'Tendencia da última semana (Filmes, Séries e Pessoas)'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const HomePage(
                              genreCode: 69,
                            )),
                  );
                },
              ),
              ListTile(
                title: const Text('Minha lista de filmes e séries'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const MoviesList()),
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
              ExpansionTile(
                title: const Text("Populares por Gênero"),
                children: [
                  ListTile(
                    title: const Text('Ação'),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HomePage(
                                  genreCode: 28,
                                )),
                      );
                    },
                  ),
                  ListTile(
                    title: const Text('Animação'),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HomePage(
                                  genreCode: 16,
                                )),
                      );
                    },
                  ),
                  ListTile(
                    title: const Text('Aventura'),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HomePage(
                                  genreCode: 12,
                                )),
                      );
                    },
                  ),
                  ListTile(
                    title: const Text('Comédia'),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HomePage(
                                  genreCode: 35,
                                )),
                      );
                    },
                  ),
                  ListTile(
                    title: const Text('Crime'),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HomePage(
                                  genreCode: 80,
                                )),
                      );
                    },
                  ),
                  ListTile(
                    title: const Text('Documentário'),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HomePage(
                                  genreCode: 99,
                                )),
                      );
                    },
                  ),
                  ListTile(
                    title: const Text('Drama'),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HomePage(
                                  genreCode: 18,
                                )),
                      );
                    },
                  ),
                  ListTile(
                    title: const Text('Entrevista'),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HomePage(
                              genreCode: 10767,
                            )),
                      );
                    },
                  ),
                  ListTile(
                    title: const Text('Família'),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HomePage(
                                  genreCode: 10751,
                                )),
                      );
                    },
                  ),
                  ListTile(
                    title: const Text('Fantasia'),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HomePage(
                                  genreCode: 14,
                                )),
                      );
                    },
                  ),
                  ListTile(
                    title: const Text('Faroete'),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HomePage(
                                  genreCode: 37,
                                )),
                      );
                    },
                  ),
                  ListTile(
                    title: const Text('Ficção'),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HomePage(
                                  genreCode: 878,
                                )),
                      );
                    },
                  ),
                  ListTile(
                    title: const Text('Filmes de Séries'),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HomePage(
                                  genreCode: 10770,
                                )),
                      );
                    },
                  ),
                  ListTile(
                    title: const Text('Guerra'),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HomePage(
                                  genreCode: 10752,
                                )),
                      );
                    },
                  ),
                  ListTile(
                    title: const Text('Guerra e Política'),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HomePage(
                              genreCode: 10768,
                            )),
                      );
                    },
                  ),
                  ListTile(
                    title: const Text('História'),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HomePage(
                                  genreCode: 36,
                                )),
                      );
                    },
                  ),
                  ListTile(
                    title: const Text('Horror'),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HomePage(
                                  genreCode: 27,
                                )),
                      );
                    },
                  ),
                  ListTile(
                    title: const Text('Infantil'),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HomePage(
                                  genreCode: 10762,
                                )),
                      );
                    },
                  ),
                  ListTile(
                    title: const Text('Mistério'),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HomePage(
                                  genreCode: 9648,
                                )),
                      );
                    },
                  ),
                  ListTile(
                    title: const Text('Musicais'),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HomePage(
                                  genreCode: 10402,
                                )),
                      );
                    },
                  ),
                  ListTile(
                    title: const Text('Notícias'),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HomePage(
                              genreCode: 10763,
                            )),
                      );
                    },
                  ),
                  ListTile(
                    title: const Text('Novelas'),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HomePage(
                              genreCode: 10766,
                            )),
                      );
                    },
                  ),
                  ListTile(
                    title: const Text('Romance'),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HomePage(
                                  genreCode: 10749,
                                )),
                      );
                    },
                  ),
                  ListTile(
                    title: const Text('Reality'),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HomePage(
                                  genreCode: 10764,
                                )),
                      );
                    },
                  ),
                  ListTile(
                    title: const Text('Seriados'),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HomePage(
                                  genreCode: 10770,
                                )),
                      );
                    },
                  ),
                  ListTile(
                    title: const Text('Thriller'),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HomePage(
                                  genreCode: 53,
                                )),
                      );
                    },
                  ),
                ],
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
                    final title = movie['title'] ?? movie['name'];
                    final overview = movie['overview'] == ''
                        ? 'Descrição indisponível'
                        : snapshot.data![index]['overview'];
                    final releaseDate =
                        movie['release_date'] ?? movie['first_air_date'];
                    final voteAverage = movie['vote_average'];
                    final img =
                        'https://image.tmdb.org/t/p/w400${movie['poster_path']}';
                    final id = movie['id'].toString();
                    final genre = movie['genre_ids'];
                    return Card(
                      color: Colors.black,
                      child: ListTile(
                        title: Text(
                          '$title',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 19,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            overview,
                            maxLines: 4,
                            overflow: TextOverflow.fade,
                            textAlign: TextAlign.center,
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailsPage(
                                title: title ?? "Título indisponível",
                                overview: overview ?? "Sinopse indisponível",
                                releaseDate: releaseDate,
                                voteAverage: voteAverage ?? "0.0",
                                img: img,
                                movieId: id,
                                genre: genre,
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
      await updateHome(page, genreCode);
    }
  }
}
