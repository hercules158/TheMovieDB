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

  String genre = "";

  genreTable() {
    switch (genreCode) {
      case 12:
        {
          genre = "Filmes de Aventura";
        }
        break;
      case 14:
        {
          genre = "Filmes de Fantasia";
        }
        break;
      case 16:
        {
          genre = "Filmes de Animação";
        }
        break;
      case 18:
        {
          genre = "Filmes de Drama";
        }
        break;
      case 27:
        {
          genre = "Filmes de Horror";
        }
        break;
      case 35:
        {
          genre = "Filmes de Comédia";
        }
        break;
      case 36:
        {
          genre = "Filmes de História";
        }
        break;
      case 37:
        {
          genre = "Filmes de Faroeste";
        }
        break;
      case 53:
        {
          genre = "Filmes Thriller";
        }
        break;
      case 80:
        {
          genre = "Filmes de Crime";
        }
        break;
      case 99:
        {
          genre = "Documentários";
        }
        break;
      case 878:
        {
          genre = "Filmes Ficção Científica";
        }
        break;
      case 9648:
        {
          genre = "Filmes de Mistério";
        }
        break;
      case 10402:
        {
          genre = "Filmes Musicais";
        }
        break;
      case 10749:
        {
          genre = "Filmes de Romance";
        }
        break;
      case 10751:
        {
          genre = "Filmes para Família";
        }
        break;
      case 10752:
        {
          genre = "Filmes de Guerra";
        }
        break;
      case 10770:
        {
          genre = "Filmes de Séries";
        }
        break;
      default:
        {
          genre = "Filmes Em Alta";
        }
    }
    return genre;
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
          title: Text(genre),
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
                title: const Text('Filmes em alta'),
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
                title: const Text('Minha lista de filmes'),
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
                            color: Colors.white,
                            fontSize: 19,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Flexible(
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              overview,
                              maxLines: 4,
                              overflow: TextOverflow.fade,
                              textAlign: TextAlign.center,
                              style: const TextStyle(color: Colors.white),
                            ),
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
      await updateHome(page, genreCode);
    }
  }
}
