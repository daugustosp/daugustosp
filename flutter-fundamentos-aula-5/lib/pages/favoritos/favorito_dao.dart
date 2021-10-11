
import 'package:bytebank/pages/carro/carro.dart';
import 'package:bytebank/pages/utils/sql/base_dao.dart';
import 'package:bytebank/pages/favoritos/favorito.dart';

class FavoritoDAO extends BaseDAO<Favorito>{
  @override
  Favorito fromMap(Map<String, dynamic> map) {
    return Favorito.fromMap(map);
  }

  @override
  // TODO: implement tableName
  String get tableName => "favorito";

}