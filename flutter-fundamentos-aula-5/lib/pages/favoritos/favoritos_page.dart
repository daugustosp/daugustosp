import 'dart:async';

import 'package:bytebank/pages/carro/CarrosListView.dart';
import 'package:bytebank/pages/carro/carro.dart';
import 'package:bytebank/pages/carro/carros_bloc.dart';
import 'package:bytebank/pages/utils/teste_erro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'favoritos_bloc.dart';



class FavoritosPage extends StatefulWidget {
  FavoritosPage();

  @override
  _FavoritosPageState createState() => _FavoritosPageState();
}

class _FavoritosPageState extends State<FavoritosPage>
    with AutomaticKeepAliveClientMixin<FavoritosPage> {

  final _bloc = FavoritosBloc();

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _bloc.fetch();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return StreamBuilder(
      stream: _bloc.stream,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return TextError("Não foi possível buscar os carros");
        }

        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        List<Carro> carros = snapshot.data;

        return RefreshIndicator(
          onRefresh: _onRefresh,
          child: CarrosListView(carros),
        );
      },
    );
  }

  Future<void> _onRefresh() {
    return _bloc.fetch();
  }
}
