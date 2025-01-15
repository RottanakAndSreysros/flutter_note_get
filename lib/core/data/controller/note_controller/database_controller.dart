import 'package:flutter_note_get/core/data/controller/note_controller/init_database.dart';
import 'package:flutter_note_get/core/data/model/text_note_model.dart';
import 'package:get/get.dart';

class DatabaseController extends GetxController {
  final _init = Get.put(InitDatabase());

  Future<void> insertData({required TextNoteModel model}) async {
    try {
      final db = await _init.initDatabase();
      await db.insert(_init.table, model.toJson());
    } catch (e) {
      rethrow;
    }
  }

  Future<List<TextNoteModel>> getData() async {
    try {
      final db = await _init.initDatabase();
      List<Map<String, dynamic>> list = await db.query(_init.table);
      return list.map((e) => TextNoteModel.fromJson(e)).toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateData({required TextNoteModel model}) async {
    try {
      final db = await _init.initDatabase();
      await db.update(
        _init.table,
        model.toJson(),
        where: 'id = ?',
        whereArgs: [model.id?.value],
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteData({required int id}) async {
    try {
      final db = await _init.initDatabase();
      await db.delete(
        _init.table,
        where: 'id = ?',
        whereArgs: [id],
      );
      update();
    } catch (e) {
      rethrow;
    }
  }

  Future<List<TextNoteModel>> getAllData() async {
    try {
      final List<TextNoteModel> listData = await getData();
      update();
      return listData;
    } catch (e) {
      rethrow;
    }
  }
}
