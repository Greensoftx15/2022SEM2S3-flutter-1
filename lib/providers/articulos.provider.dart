import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/articulo.model.dart';

class ArticuloProvider {
  Future<List<ArticuloModel>> obtenerArticulos(String q) async {
    List<ArticuloModel> articulos = [];
    var client = http.Client();

    try {
      Map<String, String> parametros = {
        'q': q,
        'from': '2022-08-29',
        'sortBy': 'publishedAt',
        'apiKey': 'df5c39422c6b4cc59805bca7b8821e95',
      };

      var url = Uri.https('newsapi.org', 'v2/everything', parametros);
      var response = await http.get(url);
      var decodedResponse =
          jsonDecode(utf8.decode(response.bodyBytes)) as Map<String, dynamic>;

      decodedResponse["articles"]
          .forEach((e) => articulos.add(ArticuloModel.fromJson(e)));

      return articulos;
    } finally {
      client.close();
    }
  }
}
