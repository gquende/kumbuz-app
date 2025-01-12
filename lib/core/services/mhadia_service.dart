import 'dart:convert';

import 'package:http/http.dart' as http;

class MhadiaService {
  String base_url = "";
  Map<String, String>? _headers;

  MhadiaService({required this.base_url}) {
    this._headers = {
      'Content-Type': 'application/json',
    };
  }

  Future<Object?> request(
      {String? endpoint,
      Map<dynamic, dynamic>? parameters = const {},
      String method = "GET"}) async {
    Uri url = Uri.parse("${this.base_url}/${endpoint}");
    // request()
    var request = http.Request(method, url);
    request.headers.addAll(_headers as Map<String, String>);

    http.Response? response;

    switch (method) {
      case "GET":
        {
          response = await http.get(url, headers: this._headers);
          break;
        }
      case "POST":
        {
          response = await http.post(url,
              headers: _headers, body: jsonEncode(parameters));

          break;
        }
      case "DELETE":
        {
          response =
              await http.delete(url, headers: this._headers, body: parameters);
          break;
        }
      case "PUT":
        {
          response =
              await http.put(url, headers: this._headers, body: parameters);
          break;
        }
    }

    if (response!.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      print(response.body);
      return null;
    }

    //return jsonDecode(response!.body);
  }

  static Future<String?> getUserFinancePerfil(Map<int, int> answers) async {
    try {
      await Future.delayed(Duration(seconds: 10));
      return "Financista";

      // return null;
    } catch (error) {}

    return "undefined";
  }
}
