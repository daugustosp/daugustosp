
import 'dart:async';

import 'package:bytebank/pages/carro/simpleBloc.dart';

import 'carro.dart';
import 'carros_api.dart';

class CarrosBloc extends SimpleBloc<List<Carro>>{

  Future<List<Carro>> fetch(String tipo) async {
    try {
      List<Carro> carros = await CarrosApi.getCarros(tipo);

      add(carros);

      return carros;
    } catch (e) {
      addError(e);
    }
  }
}