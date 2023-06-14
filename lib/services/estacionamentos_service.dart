import 'dart:convert';
import 'dart:io';
import 'package:teste/services/webclient.dart';
import 'package:http/http.dart' as http;

import '../models/estacionamento_model.dart';

class EstacionamentoService {
  static String url = Webclient.urlEstacionamentos;
  http.Client client = Webclient().client;

  Future<List<Estacionamento>> getAll() async {
    http.Response response = await client.get(Uri.parse(url));
    if (response.statusCode != 200) {
      throw HttpException(response.body);
    }

    List<Estacionamento> result = [];
    List<dynamic> jsonList = json.decode(response.body);

    for (var jsonMap in jsonList) {
      result.add(Estacionamento.fromJson(jsonMap));
    }

    return result;
  }

  Future<void> delete(String id) async {
    http.Response response = await client.delete(Uri.parse('${Uri.parse(url)}$id'));
    if (response.statusCode != 200) {
      throw HttpException(response.body);
    }
  }
}