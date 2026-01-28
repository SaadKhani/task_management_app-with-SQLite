import 'package:sqflite/sqflite.dart';
import 'package:sqlite_ad_2/database/db_helper.dart';
import '../models/task_model.dart';

class TaskRepository {
  Future<List<Task>> getTasksByUser(int userId) async {
    final Database db = await DBHelper.instance.database;
    final data = await db.query(
      'tasks',
      where: 'userId = ?',
      whereArgs: [userId],
    );
    return data.map((e) => Task.fromMap(e)).toList();
  }

  Future<void> insertTask(Task task) async {
    final db = await DBHelper.instance.database;
    await db.insert('tasks', task.toMap());
  }

  Future<void> updateTask(Task task) async {
    final db = await DBHelper.instance.database;
    await db.update(
      'tasks',
      task.toMap(),
      where: 'id = ?',
      whereArgs: [task.id],
    );
  }

  Future<void> deleteTask(int id) async {
    final db = await DBHelper.instance.database;
    await db.delete('tasks', where: 'id = ?', whereArgs: [id]);
  }
}
