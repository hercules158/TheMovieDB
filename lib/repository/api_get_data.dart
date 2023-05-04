import 'dart:convert';
import 'package:http/http.dart' as http;
import '../variables/base_url.dart';

class HomeRepository {
  var lang = '&language=pt-BR';
  Future<List> fetch() async {
    var secURL = '&language=pt-BR&page=1';
    var response = await http.get(Uri.parse(BaseURL.urlPopular + secURL));

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
    var secURL = '&page=';
    var page = i.toString();
    var response = await http.get(Uri.parse(BaseURL.urlPopular + lang + secURL + page));

    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      var results = json['results'];
      return results;
    } else {
      throw Exception('Erro ao carregar dados do Servidor!');
    }
  }

  Future<List> fetchByName(String searchName) async {
    var secURL = '&query=';
    var response = await http.get(Uri.parse(BaseURL.urlSearch + secURL + searchName + lang));

    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      var results = json['results'];
      return results;
    } else {
      throw Exception('Erro ao carregar dados do Servidor!');
    }
  }
}
