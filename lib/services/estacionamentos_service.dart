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

  Future<String> add(Estacionamento estacionamento) async {
    String estacionamentoJSON = json.encode(estacionamento.toJson());
    http.Response response = await client.post(Uri.parse(url),
        headers: {'Content-type': 'application/json'},
        body: estacionamentoJSON);
    if (response.statusCode != 201) {
      throw HttpException(response.body);
    }

    Map<String, dynamic> jsonResponse = json.decode(response.body);
    String confirmationMsg = jsonResponse['msg'];

    return confirmationMsg;
  }

  Future<String> update(Estacionamento estacionamento) async {
    String estacionamentoJSON = json.encode(estacionamento.toJson());
    http.Response response = await client.put(
        Uri.parse('${Uri.parse(url)}${estacionamento.sId}'),
        headers: {'Content-type': 'application/json'},
        body: estacionamentoJSON);
    if (response.statusCode != 200) {
      throw HttpException(response.body);
    }

    Map<String, dynamic> jsonResponse = json.decode(response.body);
    String confirmationMsg = jsonResponse['msg'];

    return confirmationMsg;
  }

  Future<void> delete(String id) async {
    http.Response response =
        await client.delete(Uri.parse('${Uri.parse(url)}$id'));
    if (response.statusCode != 200) {
      throw HttpException(response.body);
    }
  }
}
