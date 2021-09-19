import 'dart:io';

import 'package:flutter/material.dart';

void main() => runApp(flutter_app_02());

class flutter_app_02 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: ListaTransferencias(),
      ),
    );
  }
}

class ListaTransferencias extends StatefulWidget {
  final List<Transferencia> _transferencias = List();
  @override
  State<StatefulWidget> createState() {
    return ListaTransferenciasState();
  }
}

class ListaTransferenciasState extends State<ListaTransferencias> {
  @override
  Widget build(BuildContext context) {
    widget._transferencias.add(Transferencia(100.0, 1000));
     return Scaffold(
      appBar: AppBar(
        title: Text('Transferências'),
      ),
      body: ListView.builder(
        itemCount: widget._transferencias.length,
        itemBuilder: (context, indice) {
          final transferencia = widget._transferencias[indice];
          return ItemTransferencia(transferencia);
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add), onPressed: () {
        final Future<Transferencia> future = Navigator.push(context, MaterialPageRoute(builder: (context) {
          return FormularioTransferencia();
        }));
        future.then((transferenciaRecebida) {

          widget._transferencias.add(transferenciaRecebida);
          debugPrint('chegou no then do future');
          debugPrint('$transferenciaRecebida');

        });
      },),
    );
  }
}

  class FormularioTransferencia extends StatelessWidget {
  final TextEditingController _controladorCampoNumeroConta = TextEditingController();
  final TextEditingController _controladorCampoValor = TextEditingController();

  @override
  Widget build(BuildContext context) {
  return Scaffold(
  appBar: AppBar(
  title: Text('Criando Transferencia'),
  ),
  body: Column(
  children: <Widget>[
  Editor(
  controlador: _controladorCampoNumeroConta,
  dica: '0000',
  rotulo: 'Número da conta',
  ),
  Editor(
  controlador: _controladorCampoValor,
  dica: '0000',
  rotulo: 'Valor',
  icone: Icons.monetization_on,
  ),


  RaisedButton(
  child: Text('Confirmar'),
  onPressed: () {
  _criarTransferencia(context);
  },
  )
  ],
  ));
  }

  void _criarTransferencia(BuildContext context) {
  final int numeroConta = int.tryParse(_controladorCampoNumeroConta.text);
  final double valor = double.tryParse(_controladorCampoValor.text);
  if(numeroConta != null && valor != null) {
  final TransferenciaCriada = Transferencia(valor, numeroConta);
  Navigator.pop(context, TransferenciaCriada);
  }
  }
  }

  class ItemTransferencia extends StatelessWidget {
  final Transferencia _transferencia;

  ItemTransferencia(this._transferencia);

  @override
  Widget build(BuildContext context) {
  // TODO: implement build
  return Card(
  child: ListTile(
  leading: Icon(Icons.monetization_on),
  title: Text(_transferencia.valor.toString()),
  subtitle: Text(_transferencia.numeroConta.toString()),
  ),
  );
  }
  }

  class Transferencia {
  final double valor;
  final int numeroConta;

  Transferencia(this.valor, this.numeroConta);

  @override
  String toString() {
  return 'Transferencia{valor: $valor, numeroConta: $numeroConta}';
  }

  }

  class Editor extends StatelessWidget{

  final TextEditingController controlador;
  final String rotulo;
  final String dica;
  final IconData icone;

//Parametor opcional não pode ser privado e o construtor deve esta entre chaves
  Editor({this.controlador, this.rotulo, this.dica, this.icone});

  @override
  Widget build(BuildContext context) {
  return Padding(
  padding: const EdgeInsets.all(8.0),
  child: TextField(
  controller: controlador,
  style: TextStyle(fontSize: 24.0),
  decoration: InputDecoration(
  icon: icone != null ? Icon(icone) : null,
  labelText: rotulo,
  hintText: dica,
  ),
  keyboardType: TextInputType.number,
  ),
  );
  }
  }
