import 'package:cozinhando_casa2/telas/detalhes/detalhes.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import '../../modelos/Receita.dart';

class Home extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    return new HomeState();
  }
}

class HomeState extends State<Home>{
  @override
  Widget build(BuildContext context) {
    return _construirHome();
  }

  Widget _construirHome(){
    return Scaffold(
      body:  _construirListaCard(),
      appBar: _construirAppBar(),
    );
  }

  Widget _construirListaCard(){
    return FutureBuilder(
      future: DefaultAssetBundle
          .of(context)
          .loadString('assets/receitas.json'),
      builder: (contex, snapshot){
        List<dynamic> receitas = json.decode(snapshot.data.toString());
        return ListView.builder(
            itemBuilder: (BuildContext context, int index){
              Receita receita = Receita.fromJson(receitas[index]);

              return _construirCard(receita);
            },
          itemCount: receitas == null ? 0 : receitas.length,
        );
      }
    );
  }

  Widget _construirCard(receita){
   return GestureDetector(
     onTap: (){
       Navigator.push(context, MaterialPageRoute(
           builder: (context) => Detalhes(receita: receita)
       ));
     },
     child: SizedBox(
         height: 300,
         child: Card(
             margin: EdgeInsets.all(16),
             child: Column(
               children: <Widget>[
                 Stack(
                   children: <Widget>[
                     _construirImagemCard(receita.foto),
                     _construirTextoCard(receita.titulo)
                   ],
                 )
               ],
             )
         )
     ),

   );


  }

  Widget _construirTextoCard(titulo){
    return Positioned(
        bottom: 10,
        left: 10,
        child: Text(titulo, style: TextStyle(fontSize: 20))
    );
  }

  Widget _construirImagemCard(foto){
    return Image.asset(foto, fit: BoxFit.fill, height: 268);

  }

  Widget _construirAppBar(){
    return AppBar (title: Text('Cozinhar em casa'));

  }
}