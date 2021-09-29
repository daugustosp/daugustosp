import 'carro.dart';
import 'carros_api.dart';
import 'package:mobx/mobx.dart';

part 'carros_model.g.dart';

class CarrosModel = CarrosModelBase with _$CarrosModel;

abstract class CarrosModelBase with Store {
  @observable
  List<carro> carros;

  @observable
  Exception error;

  @action
 fetch(String tipo) async {
    try {
      this.carros = await CarrosApi.getCarros(tipo);

    } catch (e) {
      error = e;
    }
  }
}
