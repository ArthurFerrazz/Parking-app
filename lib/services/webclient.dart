import 'package:http/http.dart' as http;
import 'package:http_interceptor/http/intercepted_client.dart';

class Webclient {
  static const String urlEstacionamentos = "http://localhost:3000/api/estacionamentos/";
  http.Client client = InterceptedClient.build(
      requestTimeout: const Duration(seconds: 15), interceptors: []);
}