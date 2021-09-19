

import 'dart:async';

import 'package:bytebank/pages/carro/loripsum_api.dart';

class LoripsumBloc{
  final _streamController = StreamController<String>();

  Stream<String> get stream => _streamController.stream;

  fetch() async {
    String s = await LoripsumApi.getLoripsum();

    _streamController.close();
  }
  void dispose(){
    _streamController.close();
  }
}


class loripsum {
  String nome;


  loripsum(
  {this.nome});

  loripsum.fromJson(Map<String, dynamic> json) {
    nome = json['nome'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nome'] = this.nome;
    return data;
  }
}
