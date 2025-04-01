import 'dart:convert';

import 'package:http/http.dart' as http;

class OneSignalService {
  String base_url = "https://api.onesignal.com/notifications";
  Map<String, String>? _headers;
  String API_KEY;
  String APP_KEY;

  OneSignalService({required this.APP_KEY, required this.API_KEY}) {
    this._headers = {
      "Content-Type": "application/json",
      'Authorization': 'Basic $API_KEY',
      'accept': 'application/json',
    };
  }

  Future<Object?> request({required Map<String, dynamic> body}) async {
    body["app_id"] = APP_KEY;

    // var request = http.Request("POST", Uri.parse(base_url));
    // request.headers.addAll(_headers as Map<String, String>);

    var response = await http.post(Uri.parse(base_url),
        headers: _headers, body: jsonEncode(body));

    print("RESPOSTA DE ENVIO DE MENSAGEM");
    print(response.body);

    return response;
  }
}
