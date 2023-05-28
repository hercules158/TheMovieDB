import 'package:flutter/material.dart';
import 'package:movies/view/home_view.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Filmes",
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      home: const HomePage(genreCode: 0),
    );
  }
}

