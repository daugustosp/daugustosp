import 'dart:convert';

import 'package:bytebank/model/Segredo.dart';
import 'package:http/http.dart';
import 'package:sqflite/sqflite.dart';

import '../webclient.dart';

class TransactionWebClient {
  Future<List<Segredo>> findAll() async {
    final Response response =
        await client.get(baseUrl);
    final List<dynamic> decodedJson = jsonDecode(response.body);
    return decodedJson
        .map((dynamic json) => Segredo.fromJson(json))
        .toList();
  }
}

class HttpException implements Exception {
  final String message;

  HttpException(this.message);
}
