import 'dart:convert';

import 'package:crypto/crypto.dart';

String getNode(String data) {
  return data.substring(0, data.indexOf('@'));
}

String hashData(String data) {
  var value = utf8.encode(data);
  var valueHashed = sha256.convert(value);

  return valueHashed.toString();
}
