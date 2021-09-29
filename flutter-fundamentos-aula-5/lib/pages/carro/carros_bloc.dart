
import 'dart:async';

import 'package:bytebank/pages/carro/simpleBloc.dart';

import 'carro.dart';
import 'carros_api.dart';

class CarrosBloc extends SimpleBloc<List<carro>>{

  Future<List<carro>> fetch(String tipo) async {
    try {
      List<carro> carros = await CarrosApi.getCarros(tipo);

      add(carros);

      return carros;
    } catch (e) {
      addError(e);
    }
  }
}