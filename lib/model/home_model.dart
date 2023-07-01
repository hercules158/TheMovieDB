class MyMovieModel {

  final dynamic overview;
  final dynamic releaseDate;
  final dynamic title;
  final dynamic voteAverage;
  final dynamic id;
  final dynamic img;
  final dynamic genre;
  final dynamic mediaType;

  MyMovieModel(
      {this.title,
      this.genre,
      this.id,
      this.mediaType,
      this.overview,
      this.releaseDate,
      this.voteAverage,
      this.img,});

  factory MyMovieModel.fromJson(Map json) {
    return MyMovieModel(
      title: json['title'] ?? json['name'],
      overview: json['overview'] ?? 'Sinopse indisponível',
      releaseDate: json['release_date'] ?? '0001-01-01',
      voteAverage: json['vote_average'],
      img: json['poster_path'],
      id: json['id'],
      genre: json['genre_ids'],
      mediaType: json['media_type']);
  }
}

