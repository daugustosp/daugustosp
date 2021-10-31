import 'dart:convert';

import 'package:bytebank/pages/login/Usuario.dart';
import 'package:bytebank/pages/api_response.dart';
import 'package:bytebank/pages/utils/prefs.dart';
import 'package:http/http.dart' as http;

class Login {
  static Future<ApiResponse<Usuario>> login(String login, String senha) async {

    try {
      var url = Uri.parse('https://carros-springboot.herokuapp.com/api/v2/login');
      Map<String, String> headers = {
        "Content-Type": "application/json"
      };
//converter o son para String
      Map params = {
        "username": login,
        "password": senha
      };

      String s = json.encode(params);

      var response = await http.post(url, body: s, headers: headers);
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      // pegar o retorno string da respota do servico
      Map mapResponse = jsonDecode(response.body);
      if (response.statusCode == 200) {
        final user = Usuario.fromJson(mapResponse);
        user.save();
        return ApiResponse.ok(user);
      }
      return ApiResponse.error(mapResponse["error"]);
    }catch(error, exception){
      print("Erro no login $error > $exception");
      return ApiResponse.error("Não foi possivel fazer o login");
    }
  }
}
