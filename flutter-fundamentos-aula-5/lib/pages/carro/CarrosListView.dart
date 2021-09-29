
import 'dart:async';

import 'package:bytebank/pages/carro/carro_page.dart';
import 'package:bytebank/pages/utils/nav.dart';
import 'package:bytebank/pages/utils/teste_erro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';


import 'carro.dart';
import 'carros_api.dart';
import 'carros_model.dart';

class CarrosListView extends StatelessWidget {
 List<carro> carros;

 CarrosListView(this.carros);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: ListView.builder(
        itemCount: carros != null ? carros.length : 0,
        itemBuilder: (contex, index){
          carro c= carros[index];

          return Card(
            color: Colors.grey[100],
            child: Container(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Center(
                    child: Image.network(
                      c.urlFoto ?? "https://s3-sa-east-1.amazonaws.com/videos.livetouchdev.com.br/classicos/Chevrolet_Corvette.png",
                      width: 250,
                    ),
                  ),
                  Text(
                    c.nome ?? "teste",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 25),
                  ),
                  Text(
                    "descricao...",
                    style: TextStyle(fontSize: 16),
                  ),
                  // ignore: deprecated_member_use
                  ButtonBarTheme(
                    data: ButtonBarThemeData(),
                    child: ButtonBar(
                      children: <Widget>[
                        FlatButton(
                          child: const Text('DETALHES'),
                          onPressed: () => _onClickCarro(context, c),
                        ),
                        FlatButton(
                          child: const Text('SHARE'),
                          onPressed: (){/*...*/},
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  _onClickCarro(context, carro c) {
    push(context, CarroPage(c));
  }

}