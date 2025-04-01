import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

class HttpService {
  String base_url;
  String api_key;
  String? secret_key;

  HttpService({required this.base_url, required this.api_key});

  Future<http.Response> get(Uri endpoint, String auth) async {
    String authHeader = 'Token $auth';

    http.Response response = await http.get(endpoint, headers: {
      HttpHeaders.authorizationHeader: authHeader,
      HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
    });

    return response;
  }

  Future<http.Response> post(Uri endpoint, Map data, String auth) async {
    String authHeader = 'Token $auth';

    var res = (await http.post(endpoint, body: jsonEncode(data), headers: {
      HttpHeaders.authorizationHeader: authHeader,
      HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
    }));
    return res;
  }
}