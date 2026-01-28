import 'package:flutter/material.dart';
import 'package:sqlite_ad_2/data/repositories/user_repo.dart';
import '../data/models/user_model.dart';

class UserViewModel extends ChangeNotifier {
  final UserRepository _repository = UserRepository();
  List<User> users = [];

  Future<void> fetchUsers() async {
    users = await _repository.getUsers();
    notifyListeners();
  }

  Future<void> addUser(User user) async {
    await _repository.insertUser(user);
    fetchUsers();
  }

  Future<void> removeUser(int id) async {
    await _repository.deleteUser(id);
    fetchUsers();
  }
}
