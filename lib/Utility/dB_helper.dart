import 'package:flutter_app/models/model1.dart';
import 'package:flutter_app/models/model2.dart';
import 'package:flutter_app/models/model3.dart';
import 'package:flutter_app/models/model4.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class DBHelper {
  static DBHelper? _dBHelper;
  static Database? _database;

  DBHelper._createInstance();

  factory DBHelper() {
    _dBHelper ??= DBHelper._createInstance();
    return _dBHelper!;
  }

  Future<Database> get database async {
    _database ??= await initailizeDB();
    return _database!;
  }

  Future<Database> initailizeDB() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'database.db';

    var modelsDB = await openDatabase(path,
        version: 1, onConfigure: _onConfigure, onCreate: _createDB);
    return modelsDB;
  }

  _onConfigure(Database db) async {
    await db.execute("PRAGMA foreign_keys = ON");
  }

  void _createDB(Database db, int newVersion) async {
    await db.execute(
        'CREATE TABLE model1(id INTEGER PRIMARY KEY AUTOINCREMENT, model1Name TEXT NOT NULL)');

    await db.execute(
        'CREATE TABLE model2(id INTEGER PRIMARY KEY AUTOINCREMENT, model2Name TEXT NOT NULL, model1Id INTEGER NOT NULL, CONSTRAINT [FK_model2_model1] FOREIGN KEY (model1Id) REFERENCES model1 (id) ON DELETE CASCADE ON UPDATE CASCADE)');

    await db.execute('''
          CREATE TABLE model3(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            model3Name TEXT NOT NULL,
            model1Id INTEGER NOT NULL,
            model2Id INTEGER NOT NULL,
            FOREIGN KEY (model1Id) REFERENCES model1 (id) ON DELETE CASCADE,
            FOREIGN KEY (model2Id) REFERENCES model2 (id) ON DELETE CASCADE
          )
          ''');

    await db.execute('''
          CREATE TABLE model4(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            model4Name TEXT NOT NULL,
            model1Id INTEGER NOT NULL,
            model2Id INTEGER NOT NULL,
            model3Id INTEGER NOT NULL,
            FOREIGN KEY (model1Id) REFERENCES model1 (id) ON DELETE CASCADE,
            FOREIGN KEY (model2Id) REFERENCES model2 (id) ON DELETE CASCADE,
            FOREIGN KEY (model3Id) REFERENCES model3 (id) ON DELETE CASCADE
          )
          ''');
  }

  ////////////////// MOdel1 ////////////////////
  //             CRUD OPERATIONS             //
  /////////////////////////////////////////////

  Future<List<Map<String, dynamic>>> getModel1MapList() async {
    Database db = await database;
    var result =
        await db.query('model1'); //db.rawQuery('SELECT * FROM model1');
    return result;
  }

  Future<List<Model1>> getModel1List() async {
    var model1MapList = await getModel1MapList();
    int count = model1MapList.length;
    List<Model1> model1List = <Model1>[];
    for (int i = 0; i < count; i++) {
      model1List.add(Model1.fromMapObj(model1MapList[i]));
    }
    return model1List;
  }

  Future<int> insertModel1(Model1 obj) async {
    Database db = await database;
    var result = await db.insert('model1', obj.toMap());
    return result;
  }

  Future<int> updateModel1(Model1 obj) async {
    Database db = await database;
    var result = await db
        .update('model1', obj.toMap(), where: 'id=?', whereArgs: [obj.id]);
    return result;
  }

  Future<int> deleteModel1(int id) async {
    Database db = await database;
    int result = await db.rawDelete('DELETE FROM model1 WHERE id= $id');
    return result;
  }

  Future<int> getModel1Count() async {
    Database db = await database;
    List<Map<String, dynamic>> lst =
        await db.rawQuery('SELECT COUNT(*) FROM model1');
    int? result = Sqflite.firstIntValue(lst);
    return result as int;
  }

  /////////////////// MOdel2 ///////////////////
  //             CRUD OPERATIONS             //
  /////////////////////////////////////////////

  Future<List<Map<String, dynamic>>> getModel2MapList() async {
    Database db = await database;
    var result =
        await db.query('model2'); //db.rawQuery('SELECT * FROM model1');
    return result;
  }

  Future<List<Model2>> getModel2List() async {
    var model2MapList = await getModel2MapList();
    int count = model2MapList.length;
    List<Model2> model2List = <Model2>[];
    for (int i = 0; i < count; i++) {
      model2List.add(Model2.fromMapObj(model2MapList[i]));
    }
    return model2List;
  }

  Future<int> insertModel2(Model2 obj) async {
    Database db = await database;
    var result = await db.insert('model2', obj.toMap());
    // var result = await db.rawInsert(
    //     "INSERT INTO model2(model2Name, model1Id) VALUES('${obj.model2Name}', ${obj.model1Id})");
    return result;
  }

  Future<int> updateModel2(Model2 obj) async {
    Database db = await database;
    var result = await db
        .update('model2', obj.toMap(), where: 'id=?', whereArgs: [obj.id]);
    return result;
  }

  Future<int> deleteModel2(int id) async {
    Database db = await database;
    // int result = await db.rawDelete('DELETE FROM model2 WHERE id= $id');
    int result = await db.delete('model2', where: 'id=?', whereArgs: [id]);
    return result;
  }

  //////////////////// MOdel3 //////////////////
  //             CRUD OPERATIONS             //
  /////////////////////////////////////////////

  Future<List<Map<String, dynamic>>> getModel3MapList() async {
    Database db = await database;
    var result =
        await db.query('model3'); //db.rawQuery('SELECT * FROM model3');
    return result;
  }

  Future<List<Model3>> getModel3List() async {
    var model3MapList = await getModel3MapList();
    int count = model3MapList.length;
    List<Model3> model3List = <Model3>[];
    for (int i = 0; i < count; i++) {
      model3List.add(Model3.fromMapObj(model3MapList[i]));
    }
    return model3List;
  }

  Future<int> insertModel3(Model3 obj) async {
    Database db = await database;
    var result = await db.insert('model3', obj.toMap());
    return result;
  }

  Future<int> updateModel3(Model3 obj) async {
    Database db = await database;
    var result = await db
        .update('model3', obj.toMap(), where: 'id=?', whereArgs: [obj.id]);
    return result;
  }

  Future<int> deleteModel3(int id) async {
    Database db = await database;
    int result = await db.rawDelete('DELETE FROM model3 WHERE id= $id');
    return result;
  }

  //////////////////// MOdel4 //////////////////
  //             CRUD OPERATIONS             //
  /////////////////////////////////////////////

  Future<List<Map<String, dynamic>>> getModel4MapList() async {
    Database db = await database;
    var result =
        await db.query('model4'); //db.rawQuery('SELECT * FROM model4');
    return result;
  }

  Future<List<Model4>> getModel4List() async {
    var model4MapList = await getModel4MapList();
    int count = model4MapList.length;
    List<Model4> model4List = <Model4>[];
    for (int i = 0; i < count; i++) {
      model4List.add(Model4.fromMapObj(model4MapList[i]));
    }
    return model4List;
  }

  Future<int> insertModel4(Model4 obj) async {
    Database db = await database;
    var result = await db.insert('model4', obj.toMap());
    return result;
  }

  Future<int> updateModel4(Model4 obj) async {
    Database db = await database;
    var result = await db
        .update('model4', obj.toMap(), where: 'id=?', whereArgs: [obj.id]);
    return result;
  }

  Future<int> deleteModel4(int id) async {
    Database db = await database;
    int result = await db.rawDelete('DELETE FROM model4 WHERE id= $id');
    return result;
  }
}
