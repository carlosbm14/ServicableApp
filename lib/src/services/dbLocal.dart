import 'dart:io';
import 'package:appservicable/src/models/referenciaPagoModel.dart';
import 'package:appservicable/src/models/usuarioModel.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DBLocalProvider {
  DBLocalProvider._();
  static final DBLocalProvider db = new DBLocalProvider._();

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await initDB();
    return _database;
  }

  static Database _database;

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'servicable.db');

    return await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      
      await db.execute('''
              CREATE TABLE Usuario (
                nombre_usu TEXT,
                clave_usu TEXT,
                distrito TEXT,
                departamento TEXT,
                provincia TEXT,
                email TEXT,
                telefono TEXT)
              ''');
      
      await db.execute('''
              CREATE TABLE ReferenciaPago (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                referencia_pago TEXT
                )
              ''');

    });
  }

  Future close() async {
    return db.close();
  }

  Future restar() async {
    _database = null;
  }

  insertUsuario(Usuario item) async {
    final db = await database;
    final resp = await db.insert('Usuario', item.toJson());
    return resp;
  }

  insertRefPago(ReferenciaPago item) async {
    final db = await database;
    final resp = await db.insert('ReferenciaPago', item.toJson());
    return resp;
  }

  Future<int> deleteAllReferencia() async {
    final db = await database;
    final resp = await db.delete('ReferenciaPago');
    return resp;
  }

  Future<List<ReferenciaPago>> getReferenciasPago() async {
    final db = await database;
    final resp = await db.query('ReferenciaPago');
    List<ReferenciaPago> lista =
        resp.isNotEmpty ? resp.map((c) => ReferenciaPago.fromJson(c)).toList() : [];
    return lista;
  }

}
