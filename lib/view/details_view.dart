import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class DetailsPage extends StatelessWidget {

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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalhes do filme'),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          Column(
            children: [
              const Padding(padding: EdgeInsets.all(0.0)),
              Image.network(img),
              Column(
                children: [
                  const Padding(padding: EdgeInsets.all(8.0)),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      title,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 18, decoration: TextDecoration.underline),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
              Column(children: [
                const Padding(padding: EdgeInsets.all(8.0)),
                Text(DateFormat('dd-MM-yyyy')
                    .format(DateTime.parse(releaseDate))),
              ]),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    title: Text(overview, textAlign: TextAlign.center),
                  ),
                ),
              ),
              ListTile(
                title: Text(
                  'Nota Média: $voteAverage',
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
