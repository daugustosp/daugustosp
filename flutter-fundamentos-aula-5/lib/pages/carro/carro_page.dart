import 'package:bytebank/pages/carro/carro.dart';
import 'package:bytebank/pages/carro/loripsum_api.dart';
import 'package:bytebank/pages/favoritos/favorito_service.dart';
import 'package:bytebank/pages/utils/nav.dart';
import 'package:bytebank/pages/utils/text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';

import 'carro_form_page.dart';



class CarroPage extends StatefulWidget {
  Carro car;

  CarroPage(this.car);

  @override
  _CarroPageState createState() => _CarroPageState();
}

class _CarroPageState extends State<CarroPage> {
  final _loripsumApiBloc = LoripsumBloc();
   Color Colores = Colors.grey;

  Carro get carro => widget.car;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loripsumApiBloc.fetch();

    FavoritoService.isFavorito(carro).then((bool favorito) {
      setState(() {
        Colores = favorito ? Colors.red : Colors.grey;
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.car.nome),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.place),
              onPressed: _onClickMapa,
            ),
            IconButton(
              icon: Icon(Icons.videocam),
              onPressed: _onClickVideo,
            ),
            PopupMenuButton<String>(
              onSelected: (String value) => _onClickPopupMenu(value),
              itemBuilder: (BuildContext context){
                return [
                  PopupMenuItem(value: "Editar", child: Text("Editar"),),
                  PopupMenuItem(value: "Deletar", child: Text("Deletar"),),
                  PopupMenuItem(value: "Share", child: Text("Share"),)

                ];
              },
            )
          ],
        ),
        body: _body()
    );
  }

  _body() {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: <Widget>[
            CachedNetworkImage(
                imageUrl:  widget.car.urlFoto),
            _bloco1(),
            Divider(),
            _bloco2(),

          ],
        ),
      ),
    );
  }

  Row _bloco1() {

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            text(widget.car.nome, fontSize: 20, bold: true),
            text(widget.car.tipo,fontSize: 16),

          ],
        ),
        Row(
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.favorite, color: Colores, size: 40,),
                 onPressed: _onClickFavorito,
            ),

            IconButton(
              icon: Icon(Icons.share, size: 40,),
              onPressed: _onClickShare,
            )
          ],
        )
      ],
    );
  }

  _bloco2() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 20,),
        text(widget.car.descricao, fontSize: 16, bold: true),
        SizedBox(height: 20,),
        StreamBuilder<String>(
          stream: _loripsumApiBloc.stream,
          builder: (BuildContext context, AsyncSnapshot snapshot){
            if(!snapshot.hasData){
              return Center(child: CircularProgressIndicator(),);
            }
            return text(snapshot.data, fontSize: 16);
          },
        )
      ],
    );
  }

  void _onClickMapa() {
  }

  void _onClickVideo() {
  }

  _onClickPopupMenu(String value){
    switch(value){
      case "Editar":
        print("Editar !!!");
        push(context, CarroFormPage(carro: carro));
        break;
      case "Deletar":
        print("Deletar !!!");
        break;
      case "Share":
        print("DShare !!!");
        break;
    }
  }

  void _onClickFavorito() async {

    bool favorito = await FavoritoService.favoritar(carro);

    setState(() {
      Colores = favorito ? Colors.red : Colors.grey;
    });

  }

  void _onClickShare() {
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _loripsumApiBloc.dispose();
  }
}