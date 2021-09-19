
import 'dart:convert';

import 'package:bytebank/pages/carro/carro.dart';
import 'package:bytebank/pages/login/Usuario.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class TipoCarro{
  static final String classicos = "classicos";
  static final String esportivos = "esportivos";
  static final String luxo = "luxo";

}

class CarrosApi {

static Future<List<carro>> getCarros(String tipo) async{

 Usuario user = await Usuario.get();

 Map<String, String> headers = {
   "Content-Type": "application/json",
   "Authorization": "Bearer ${user.token}"
 };

  var url = 'https://carros-springboot.herokuapp.com/api/v2/carros/tipo/$tipo';
   print(url);
  var response = await http.get(url, headers: headers);
  String json = response.body;
  print(json);
  try {
    List list = convert.json.decode(json);

    return list.map<carro>((map) => carro.fromJson(map)).toList();
  } catch(error, exception){
    print("$error > $exception");
    throw error;
  }

}
}