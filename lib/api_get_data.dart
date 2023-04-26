import 'dart:convert';
import 'package:http/http.dart' as http;

class RequestAPI {
  Future<List> fetch() async {
    var urlf = 'https://api.themoviedb.org/3/movie/popular?api_key=';
    var apiKey = 'cfc0ade742438ee84c9021437abb434c';
    var urll = '&language=pt-BR&page=1';
    var response = await http.get(Uri.parse(urlf + apiKey + urll));

    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      var results = json['results'];
      var numPages = 4;
      for (int i = 2; i <= numPages; i++) {
        results =
            results + await fetchAux(i); //Recebe o resultado da pagina 1 à 5
      }

      return results;
    } else {
      throw Exception('Erro ao carregar dados do Servidor!');
    }
  }

  Future<List> fetchAux(int i) async {
    var urlf = 'https://api.themoviedb.org/3/movie/popular?api_key=';
    var apiKey = 'cfc0ade742438ee84c9021437abb434c';
    var urll = '&language=pt-BR&page=';
    var page = i.toString();
    var response = await http.get(Uri.parse(urlf + apiKey + urll + page));

    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      var results = json['results'];
      return results;
    } else {
      throw Exception('Erro ao carregar dados do Servidor!');
    }
  }

  Future<List> fetchByName(String searchName) async {
    var urlf = 'https://api.themoviedb.org/3/search/movie?api_key=';
    var apiKey = 'cfc0ade742438ee84c9021437abb434c';
    var urll = '&query=';
    var lang = '&language=pt-BR';
    var response = await http.get(Uri.parse(urlf + apiKey + urll + searchName + lang));

    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      var results = json['results'];
      return results;
    } else {
      throw Exception('Erro ao carregar dados do Servidor!');
    }
  }
}
