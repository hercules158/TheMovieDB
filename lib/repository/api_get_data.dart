import 'dart:convert';
import 'package:http/http.dart' as http;
import '../const/base_url.dart';

class HomeRepository {
  var lang = '&language=pt-BR';

  Future<List> fetch(int numPage, int genreCode) async {
    if (genreCode == 0) {
      var secURL = '&language=pt-BR&page=$numPage&sort_by=popularity.desc';
      var response = await http.get(Uri.parse(BaseURL.urlPopular + secURL));

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        var results = json['results'];
        return results;
      } else {
        throw Exception('Erro ao carregar dados do Servidor!');
      }
    } else if (genreCode == 69) {
      //Tendencia (Filmes, Series e Pessoas)
      var secURL = '&language=pt-BR&page=$numPage&sort_by=popularity.desc';
      var response =
          await http.get(Uri.parse(BaseURL.urlTrendingWeekMix + secURL));

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        var results = json['results'];
        return results;
      } else {
        throw Exception('Erro ao carregar dados do Servidor!');
      }
    } else {
      var secURL = '&language=pt-BR&page=$numPage';
      var response = await http
          .get(Uri.parse(BaseURL.urlGenreHot + genreCode.toString() + secURL));

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        var results = json['results'];
        return results;
      } else {
        throw Exception('Erro ao carregar dados do Servidor!');
      }
    }
  }

  Future<List> fetchByName(String searchName) async {
    var secURL = '&query=';
    var response = await http
        .get(Uri.parse(BaseURL.urlSearch + secURL + searchName + lang));

    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      var results = json['results'];
      return results;
    } else {
      throw Exception('Erro ao carregar dados do Servidor!');
    }
  }
}
