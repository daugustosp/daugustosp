import 'package:bytebank/pages/carro/carro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CarroPage extends StatelessWidget {
  carro car;

  CarroPage(this.car);

  @override
  Widget build(BuildContext context) {
   return Scaffold(
     appBar: AppBar(
       title: Text(car.nome),
       actions: <Widget>[
       IconButton(
         icon: Icon(Icons.place),
         onPressed: _onClickMapa,
   ),
         IconButton(
           icon: Icon(Icons.videocam),
           onPressed: _onClickVideo,
         ),
       ],
     ),
     body: _body()
   );
  }

  _body() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Image.network(car.urlFoto),
    );
  }


  void _onClickMapa() {
  }

  void _onClickVideo() {
  }
}