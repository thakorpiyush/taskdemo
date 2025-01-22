

import 'package:demoproject/src/app/model/task_model.dart';
import 'package:demoproject/src/services/sqlite_manager/sqlite_manager.dart';

class TaskRepositery {
  final SQLiteManager _dbManager = SQLiteManager();

  Future<List<TaskModel>> fetchItems() async {
    final db = await _dbManager.database;
    final result = await db.query('tasks');
    return result.map((map) => TaskModel.fromMap(map)).toList();
  }

  Future<void> addItem(TaskModel item) async {
    final db = await _dbManager.database;
    await db.insert('tasks', item.toMap());
  }

  Future<void> updateItem(TaskModel item) async {
    final db = await _dbManager.database;
    await db.update('tasks', item.toMap(), where: 'id = ?', whereArgs: [item.id]);
  }

  Future<void> deleteItem(int id) async {
    final db = await _dbManager.database;
    await db.delete('tasks', where: 'id = ?', whereArgs: [id]);
  }
}