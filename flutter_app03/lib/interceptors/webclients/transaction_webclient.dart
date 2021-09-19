import 'dart:convert';

import 'package:flutter_app03/http/webclient.dart';
import 'package:flutter_app03/modelos/transaction.dart';
import 'package:http/http.dart';

class TransactionWebClient{
  Future<List<Transaction>> findAll() async {
    final Response response = await client
        .get(baseUrl)
        .timeout(Duration(seconds: 5));
    List<Transaction> transactions = _toTransactions(response);
    return transactions;
  }

  List<Transaction> _toTransactions(Response response) {
    final List<dynamic> decodedJson = jsonDecode(response.body);
    return decodedJson.map((dynamic json)=> Transaction.fromJson(json)).toList();
  }

  Future<Transaction> save(Transaction transaction) async{
    final String transactionJson = jsonEncode(transaction.toJson());
    final Response response = await client.post(baseUrl, headers:  { 'Content-type' : 'application/json',
      'password' : '1000',
    }, body: transactionJson);
    return Transaction.fromJson(jsonDecode(response.body));

  }

}