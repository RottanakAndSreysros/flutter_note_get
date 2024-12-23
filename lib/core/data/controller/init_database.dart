import 'dart:io';

import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class InitDatabase extends GetxController {
  final String table = "dating_note";

  Future<Database> initDatabase() async {
    try {
      Directory directory = await getApplicationDocumentsDirectory();
      String path = "${directory.path}/database.db";

      return await openDatabase(
        path,
        version: 1,
        onOpen: (db) {},
        onCreate: (db, version) async {
          await _oncreateDatabase(db.batch());
        },
        onUpgrade: (db, oldVersion, newVersion) {},
      );
    } catch (e) {
      // ignore: avoid_print
      print(
          "====================================Error initializing database: $e");
      rethrow;
    }
  }

  Future<void> _oncreateDatabase(Batch batch) async {
    batch.execute(
        "CREATE TABLE $table (id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,title TEXT,description TEXT,date_time TEXT);");
    await batch.commit();
  }
}
