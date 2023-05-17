import 'dart:convert';
import 'package:http/http.dart' as http;
import '../const/base_url.dart';

class HomeRepository {

  var lang = '&language=pt-BR';

  Future<List> fetch(int numPage) async {
    var secURL = '&language=pt-BR&page=$numPage';
    var response = await http.get(Uri.parse(BaseURL.urlPopular + secURL));

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      var results = json['results'];

      for (int i = 2; i <= numPage; i++) {
        results =
            results + await fetchAux(i); //Recebe o resultado das n paginas
      }
      return results;
    } else {
      throw Exception('Erro ao carregar dados do Servidor!');
    }
  }

  Future<List> fetchAux(int i) async {
    var secURL = '&page=';
    var page = i.toString();
    var response =
        await http.get(Uri.parse(BaseURL.urlPopular + lang + secURL + page));

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
