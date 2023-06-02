import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:movies/repository/api_get_data.dart';
import 'package:movies/repository/shared_preferences.dart';
import 'package:movies/view/video_player.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class DetailsPage extends StatefulWidget {
  final dynamic overview;
  final String releaseDate;
  final String title;
  final dynamic voteAverage;
  final String img;
  final String movieId;

  const DetailsPage({
    super.key,
    required this.title,
    required this.overview,
    required this.releaseDate,
    required this.voteAverage,
    required this.img,
    required this.movieId,
  });

  @override
  State<StatefulWidget> createState() => _DetailsPage();
}

class DetailsState extends ChangeNotifier {
  String id = '_ma8MMmx72A';

  void setId(idCode) {
    id = idCode;
    notifyListeners();
  }
}

class _DetailsPage extends State<DetailsPage> {
  SharedPref sharedPref = SharedPref();
  IconData listIcon = Icons.playlist_add_circle;
  var apiGetData = HomeRepository();
  var movieName;
  var movieLoad;
  final videoURL = 'http://www.youtube.com/watch?v=';
  List<dynamic> response = [];
  final DetailsState _mControler = DetailsState();
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    loadSharedPrefs();
    getURLId();
    _controller = YoutubePlayerController(
        initialVideoId: _mControler.id,
        flags: const YoutubePlayerFlags(autoPlay: false));
    _mControler.addListener(_idListener);
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

  getURLId() async {
    response.add(await apiGetData.fetchVideo(widget.movieId));
    var responseObject = response.first;
    responseObject = responseObject[0];
    responseObject = responseObject['key'].toString();
    _mControler.setId(responseObject);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white12,
      appBar: AppBar(
        title: const Text('Detalhes'),
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
              Padding(
                padding: const EdgeInsets.only(left:100.0,right: 100,top: 40,bottom: 20),
                child: ListTile(
                  title: const Text("Trailer",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white)),
                  subtitle: const Padding(
                    padding: EdgeInsets.all(25.0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.play_circle_fill_outlined,
                            color: Colors.red,
                            size: 100,
                          )
                        ]),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => VideoPlayer(
                          id: _mControler.id,
                        ),
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  void _idListener() async {
    _controller = YoutubePlayerController(
        initialVideoId: _mControler.id,
        flags: const YoutubePlayerFlags(autoPlay: false));
  }
}

