
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MovieModel  {
 //Todo Ainda não foi imprementado, não sei como criar uma data class

  final dynamic overview;
  final String releaseDate;
  final String title;
  final dynamic voteAverage;
  final String img;

  const MovieModel({
    required this.title,
    required this.overview,
    required this.releaseDate,
    required this.voteAverage,
    required this.img});



}