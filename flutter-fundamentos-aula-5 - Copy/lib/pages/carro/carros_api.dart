
import 'dart:convert';

import 'package:bytebank/pages/carro/carro.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class TipoCarro{
  static final String classicos = "classicos";
  static final String esportivos = "esportivos";
  static final String luxo = "luxo";

}

class CarrosApi {

static Future<List<carro>> getCarros(String tipo) async{

  var url = 'https://carros-springboot.herokuapp.com/api/v1/carros/tipo/$tipo';
   print(url);
  var response = await http.get(url);
  String json = response.body;
  print(json);
  List list = convert.json.decode(json);

  return list.map<carro>((map) => carro.fromJson(map)).toList();


}
}