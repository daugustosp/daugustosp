import 'dart:async';

import 'package:bytebank/pages/carro/simpleBloc.dart';

import '../api_response.dart';
import 'Usuario.dart';
import 'login_api.dart';

class LoginBloc{
final buttonBloc = BooleanBloc();

  Future<ApiResponse<Usuario>> login(String login, String senha) async {

    buttonBloc.add(true);

    ApiResponse response = await Login.login(login, senha);
    buttonBloc.add(false);
    return response;
  }
  void dispose(){
    buttonBloc.dispose();

  }
}