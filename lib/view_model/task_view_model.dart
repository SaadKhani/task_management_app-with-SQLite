import 'package:flutter/material.dart';
import 'package:sqlite_ad_2/data/repositories/task_repo.dart';
import '../data/models/task_model.dart';

class TaskViewModel extends ChangeNotifier {
  final TaskRepository _repository = TaskRepository();
  List<Task> tasks = [];

  Future<void> fetchTasks(int userId) async {
    tasks = await _repository.getTasksByUser(userId);
    notifyListeners();
  }

  Future<void> addTask(Task task) async {
    await _repository.insertTask(task);
    fetchTasks(task.userId);
  }

  Future<void> updateTask(Task task) async {
    await _repository.updateTask(task);
    fetchTasks(task.userId);
  }

  Future<void> deleteTask(int id, int userId) async {
    await _repository.deleteTask(id);
    fetchTasks(userId);
  }
}
