
import 'package:bytebank/Widgets/app_button.dart';
import 'package:bytebank/Widgets/app_text.dart';
import 'package:bytebank/pages/api_response.dart';
import 'package:bytebank/pages/carro/home_page.dart';
import 'package:bytebank/pages/utils/alert.dart';
import 'package:bytebank/pages/utils/nav.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'Usuario.dart';
import 'login_api.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _tLogin = TextEditingController();

  final _tSenha = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  final _focusSenha = FocusNode();

  bool _showProgress = false;

@override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Carros"),
      ),
      body: _body(),
    );
  }

  _body() {
    return Form(
      key: _formKey,
      child: Container(
        padding: EdgeInsets.all(16),
        child: ListView(
          children: <Widget>[

            AppText("Login", "Digite o login",
                controller: _tLogin,
                validator: _validateLogin,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
              
            ),

            SizedBox(
              height: 10,
            ),
            AppText("Senha",
                "Digite a senha",
                password: true,
                controller: _tSenha,
                validator: _validateSenha,
                keyboardType: TextInputType.number,
                focusNode: _focusSenha
            ),
            SizedBox(
              height: 20,
            ),
            AppButton("Login",
              onPressed: _onClickLogin,
              showProgress: _showProgress,
            ),
          ],
        ),
      ),
    );
  }


  void _onClickLogin() async{

    if(! _formKey.currentState.validate()){
      return;
    }

    String login = _tLogin.text;
    String senha = _tSenha.text;

    setState(() {
      _showProgress = true;
    });

   ApiResponse response = await Login.login(login, senha);
   if(response.ok){
     Usuario user = response.result;
     print(">>>. $user");
     push(context, HomePage(), replace: true);
   } else{
     alert(context, response.msg);
   }
    setState(() {
      _showProgress = false;
    });
  }

  String _validateLogin(String text) {

    if(text.isEmpty){
      return "Digite o Login";
    }
    return null;
  }

  String _validateSenha(String text) {

    if(text.isEmpty){
      return "Digite a senha";
    }
    if(text.length < 3){
      return "A senha precisa ter pelo menos 3 numeros";
    }
    return null;
  }
}