import 'package:sqflite/sqflite.dart';
import 'package:sqlite_ad_2/database/db_helper.dart';
import '../models/user_model.dart';

class UserRepository {
  Future<List<User>> getUsers() async {
    final Database db = await DBHelper.instance.database;
    final data = await db.query('users');
    return data.map((e) => User.fromMap(e)).toList();
  }

  Future<void> insertUser(User user) async {
    final db = await DBHelper.instance.database;
    await db.insert('users', user.toMap());
  }

  Future<void> deleteUser(int id) async {
    final db = await DBHelper.instance.database;
    await db.delete('users', where: 'id = ?', whereArgs: [id]);
  }
}
