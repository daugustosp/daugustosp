
import 'dart:async';

import 'package:bytebank/pages/carro/carro.dart';
import 'package:bytebank/pages/carro/simpleBloc.dart';
import 'package:bytebank/pages/carro/carro_dao.dart';
import 'package:bytebank/pages/favoritos/favorito.dart';
import 'favorito_service.dart';

class FavoritosBloc extends SimpleBloc<List<Carro>>{

  Future<List<Carro>> fetch() async {
    try {

      List<Carro> carros = await FavoritoService.getCarros();

      final dao = CarroDAO();

      if(carros.isEmpty) {
        // Salvar todos os carros
        carros.forEach(dao.save);
      }
      add(carros);

      return carros;
    } catch (e) {
      addError(e);
    }
  }


}