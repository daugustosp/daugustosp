import 'dart:async';

import 'package:bytebank/pages/carro/carro.dart';
import 'package:sqflite/sqflite.dart';

import 'db_helper.dart';

// Data Access Object
class CarroDAO {

  Future<Database> get db => DatabaseHelper.getInstance().db;

  Future<int> save(carro cars) async {
    var dbClient = await db;
    var id = await dbClient.insert("carro", cars.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    print('id: $id');
    return id;
  }

  Future<List<carro>> findAll() async {
    final dbClient = await db;

    final list = await dbClient.rawQuery('select * from carro');

    final carros = list.map<carro>((json) => carro.fromJson(json)).toList();

    return carros;
  }

  Future<List<carro>> findAllByTipo(String tipo) async {
    final dbClient = await db;

    final list = await dbClient.rawQuery('select * from carro where tipo =? ',[tipo]);

    final carros = list.map<carro>((json) => carro.fromJson(json)).toList();

    return carros;
  }

  Future<carro> findById(int id) async {
    var dbClient = await db;
    final list =
    await dbClient.rawQuery('select * from carro where id = ?', [id]);

    if (list.length > 0) {
      return new carro.fromJson(list.first);
    }

    return null;
  }

  Future<bool> exists(carro cars) async {
    carro c = await findById(cars.id);
    var exists = c != null;
    return exists;
  }

  Future<int> count() async {
    final dbClient = await db;
    final list = await dbClient.rawQuery('select count(*) from carro');
    return Sqflite.firstIntValue(list);
  }

  Future<int> delete(int id) async {
    var dbClient = await db;
    return await dbClient.rawDelete('delete from carro where id = ?', [id]);
  }

  Future<int> deleteAll() async {
    var dbClient = await db;
    return await dbClient.rawDelete('delete from carro');
  }
}