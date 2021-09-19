
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'carro.dart';
import 'carros_api.dart';

class CarrosListView extends StatefulWidget{
  String tipo;
  CarrosListView(this.tipo);

  @override
  _CarrosListViewState createState() => _CarrosListViewState();
}

class _CarrosListViewState extends State<CarrosListView> with AutomaticKeepAliveClientMixin<CarrosListView> {

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return _body();
  }

  _body() {
    Future<List<carro>> future = CarrosApi.getCarros(widget.tipo);
    return FutureBuilder(
      future: future,
      builder: (context, snapshot){

        if(snapshot.hasError){
          return Center(
            child: Text("Não foi possivel buscar os carros", style: TextStyle(color: Colors.red),),
          );
        }

        if(! snapshot.hasData){
          return Center(child: CircularProgressIndicator(),);
        }
        List<carro> carros = snapshot.data;
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
                  ButtonTheme(
                    child: ButtonBar(
                      children: <Widget>[
                        FlatButton(
                          child: const Text('DETALHES'),
                          onPressed: (){/*...*/},
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

}