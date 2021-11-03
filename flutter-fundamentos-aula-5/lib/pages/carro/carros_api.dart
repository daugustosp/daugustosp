
import 'dart:convert' as convert;
import 'dart:io';

import 'package:bytebank/pages/api_response.dart';
import 'package:bytebank/pages/carro/carro_dao.dart';
import 'package:bytebank/pages/carro/upload_service.dart';
import 'package:bytebank/pages/favoritos/favorito_service.dart';
import 'package:bytebank/pages/login/Usuario.dart';
import 'package:http/http.dart' as http;

import 'carro.dart';

class TipoCarro {
  static final String classicos = "classicos";
  static final String esportivos = "esportivos";
  static final String luxo = "luxo";
}

class CarrosApi {

  static Future<ApiResponse<bool>> deletar(Carro c) async{
    //buscou o usuario logado no aplicativo
    Usuario user = await Usuario.get();
    int id = c.id;
    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer ${user.token}"
    };

    var url = Uri.parse('https://carros-springboot.herokuapp.com/api/v2/carros/$id');

    print("DELETE > $url");

    var response = await http.delete(url, headers: headers);
     print('Response Status : ${response.statusCode}');

    if(response.statusCode == 200){
      Map mapResponse = convert.json.decode(response.body);
      Carro carro = Carro.fromMap(mapResponse);

      print("Carro deletado com sucesso: ${c.id} ");
      print('Response body : ${response.body}');
      final daocarro = CarroDAO();
       daocarro.delete(carro.id);
       FavoritoService.favoritar(c);
      return ApiResponse.ok(true);
    }
    Map mapResponse = convert.json.decode(response.body);
    return ApiResponse.error(mapResponse["error"]);
  }


  static Future<ApiResponse<bool>> save(Carro c, File file) async{

        if(file != null){
        final response = await UploadService.upload(file);
        }


    //buscou o usuario logado no aplicativo
    Usuario user = await Usuario.get();

    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer ${user.token}"


    };

    var url = Uri.parse('https://carros-springboot.herokuapp.com/api/v2/carros/');

    print("POST > $url");

    String json = c.toJson();

    var response = await http.post(url, body: json, headers: headers);

    print('Response Status : ${response.statusCode}');
    print('Response body : ${response.body}');

    if(response.statusCode == 201 || response.statusCode == 200){
      Map mapResponse = convert.json.decode(response.body);
      Carro carro = Carro.fromMap(mapResponse);

      print("Novo Carro: ${carro.id} ");
      print("Novo Carro: ${carro.urlFoto} ");

      return ApiResponse.ok(true);
    }
    Map mapResponse = convert.json.decode(response.body);
    return ApiResponse.error(mapResponse["error"]);

  }

  static Future<List<Carro>> getCarros(String tipo) async {
    Usuario user = await Usuario.get();

    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer ${user.token}"
    };

    var url = Uri.parse('https://carros-springboot.herokuapp.com/api/v2/carros/tipo/$tipo');

    print("GET > $url");

    var response = await http.get(url, headers: headers);

    String json = response.body;

    List list = convert.json.decode(json);

    List<Carro> carros = list.map<Carro>((map) => Carro.fromMap(map)).toList();


    return carros;
  }
}
