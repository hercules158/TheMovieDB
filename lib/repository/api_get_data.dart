import 'dart:convert';
import 'package:http/http.dart' as http;
import '../const/base_url.dart';
import '../const/tv_genre_list.dart';

class HomeRepository {
  var lang = '&language=pt-BR';

  Future<List> fetch(int numPage, int genreCode) async {
    List<dynamic> results = [];
    if (genreCode == 0) {
      var secURL = '&language=pt-BR&page=$numPage&sort_by=popularity.desc';
      var response = await http
          .get(Uri.parse(BaseURL.baseURL + BaseURL.urlMoviePopular + secURL));

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        results.addAll(json['results']);
        for (var element = 0; element < results.length; element++) {
          results[element].addAll({"media_type": "movie"});
        }
      } else {
        throw Exception('Erro ao carregar dados do Servidor!');
      }
      response = await http
          .get(Uri.parse(BaseURL.baseURL + BaseURL.urlTvPopular + secURL));
      if (response.statusCode == 200) {
        var resultsLength = results.length;
        final json = jsonDecode(response.body);
        results.addAll(json['results']);
        for (var element = resultsLength; element < results.length; element++) {
          results[element].addAll({"media_type": "tv"});
        }
      } else {
        throw Exception('Erro ao carregar dados do Servidor!');
      }
      return results;
    } else if (genreCode == 69) {
      //Tendencia (Filmes, Series e Pessoas)
      var secURL = '&language=pt-BR&page=$numPage&sort_by=popularity.desc';
      var response = await http.get(
          Uri.parse(BaseURL.baseURL + BaseURL.urlTrendingWeekMix + secURL));

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        results.addAll(json['results']);
        return results;
      } else {
        throw Exception('Erro ao carregar dados do Servidor!');
      }
    } else {
      var secURL = '&language=pt-BR&page=$numPage';
      if (TvGenre.genreCodes["tv"]!.contains(genreCode.toString())) {
        var response = await http.get(Uri.parse(BaseURL.baseURL +
            BaseURL.urlGenreHotTv +
            genreCode.toString() +
            secURL));
        if (response.statusCode == 200) {
          final json = jsonDecode(response.body);
          var resultsLength = results.length;
          results.addAll(json['results']);
          for (var element = resultsLength; element < results.length; element++) {
            results[element].addAll({"media_type": "serie"});
          }
          return results;
        } else {
          throw Exception('Erro ao carregar dados do Servidor!');
        }
      } else {
        var response = await http.get(Uri.parse(BaseURL.baseURL +
            BaseURL.urlGenreHotMovie +
            genreCode.toString() +
            secURL));
        if (response.statusCode == 200) {
          final json = jsonDecode(response.body);
          var resultsLength = results.length;
          results.addAll(json['results']);
          for (var element = resultsLength; element < results.length; element++) {
            results[element].addAll({"media_type": "movie"});
          }
          return results;
        } else {
          throw Exception('Erro ao carregar dados do Servidor!');
        }
      }
    }
  }

  Future<List> fetchByName(String searchName) async {
    var secURL = '&query=';
    var response = await http.get(Uri.parse(
        BaseURL.baseURL + BaseURL.urlSearch + secURL + searchName + lang));

    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      var results = json['results'];
      return results;
    } else {
      throw Exception('Erro ao carregar dados do Servidor!');
    }
  }

  Future<List> fetchVideo(String movieId, String mediaType) async {
    var midURL = '';

    if (mediaType == "movie" || mediaType == '') {
      midURL = 'movie/';
    } else {
      midURL = 'tv/';
    }

    var secURL =
        '/videos?language=pt-BR&api_key=cfc0ade742438ee84c9021437abb434c';
    var response =
        await http.get(Uri.parse(BaseURL.baseURL + midURL + movieId + secURL));

    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      var results = json['results'];
      if (results.length == 0) {
        secURL =
            '/videos?language=pt-PT&api_key=cfc0ade742438ee84c9021437abb434c';
        response = await http
            .get(Uri.parse(BaseURL.baseURL + midURL + movieId + secURL));
        var json = jsonDecode(response.body);
        var results = json['results'];
        if (results.length == 0) {
          secURL =
              '/videos?language=en-US&api_key=cfc0ade742438ee84c9021437abb434c';
          response = await http
              .get(Uri.parse(BaseURL.baseURL + midURL + movieId + secURL));
          var json = jsonDecode(response.body);
          var results = json['results'];
          return results;
        } else {
          return results;
        }
      } else {
        var json = jsonDecode(response.body);
        var results = json['results'];
        return results;
      }
    } else {
      throw Exception('Erro ao carregar dados do Servidor!');
    }
  }
}
