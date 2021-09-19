
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

class CarrosListView extends StatefulWidget{
  String tipo;
  CarrosListView(this.tipo);

  @override
  _CarrosListViewState createState() => _CarrosListViewState();
}

class _CarrosListViewState extends State<CarrosListView> with AutomaticKeepAliveClientMixin<CarrosListView> {
  List<carro> carros;

  final _model = CarrosModel();
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _model.fetch(widget.tipo);

  }


  @override
  Widget build(BuildContext context) {
    super.build(context);

   return Observer(
        builder: (_){
          List<carro> carros = _model.carros;

          if(_model.error != null){
           return TextError("Não foi possivel buscar os carros");
            }

          if (carros == null){
            return Center(
              child: CircularProgressIndicator(),
            );
            }


          return _listView(carros);
          },
   );
  }

  Container _listView(List<carro> carros) {
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
                          onPressed: () => _onClickCarro(c),
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

  _onClickCarro(carro c) {
    push(context, CarroPage(c));
  }

}