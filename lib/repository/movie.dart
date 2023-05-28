class Movie {
  String movieName;

  Movie(this.movieName);

  Movie.fromJson(Map<String, dynamic> json)
      : movieName = json['movieName'];

  Map<String, dynamic> toJson() => {
    'movieName': movieName,
  };
}