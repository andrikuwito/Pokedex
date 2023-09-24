import 'dart:io';
import 'dart:isolate';
import 'dart:ui';
import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

class DBHelper {
  static late Database database;
  static Future<String> createDB() async {
    var dir;
    if(Platform.isAndroid) {
      dir = await getExternalStorageDirectory();

    }else{
      dir = await getApplicationDocumentsDirectory();
    }

    var dbPath = path.join(dir!.path, "Pokedex.db");
    bool dbExists= await File(dbPath).exists();

    if (!dbExists) {
      // Copy from asset
      ByteData data = await rootBundle.load(path.join("assets", "Pokedex.db"));
      List<int> bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

      // Write and flush the bytes written
      await File(dbPath).writeAsBytes(bytes, flush: true);
      return "done";
    }
    else{
      return "avail";
    }
  }


  static Future<String> openDB() async {
    final dir;
    if(Platform.isAndroid) {
      dir = await getExternalStorageDirectory();
    }else{
      dir = await getApplicationDocumentsDirectory();
    }

    var dbPath = path.join(dir!.path, "Pokedex.db");
    bool dbExists= await File(dbPath).exists();

    if(dbExists){
      database = await openDatabase(dbPath);
      return "open";
    }
    else{
      return "closed";
    }
  }
  static Future<dynamic> selectGlobalQuery(String query) async {
    List<Map> list = await database.rawQuery(query);
    return list;
  }

  static Future<dynamic> updateGlobal(String sql) async {
    await database.rawUpdate(sql);
  }
  static Future<dynamic> insertGlobal(String sql) async{
    await database.rawInsert(sql);

  }
  static Future<dynamic> deleteGlobal(String sql) async {
    await database.rawDelete(sql);
  }

  static Future<dynamic> insertNewTable(String sql) async {
    await database.execute(sql);
  }


}