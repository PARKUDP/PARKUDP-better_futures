import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class Task {
  String name;
  String dueDate;

  Task({required this.name, required this.dueDate});

  Map<String, dynamic> toJson() => {
        'name': name,
        'dueDate': dueDate,
      };

  factory Task.fromJson(Map<String, dynamic> json) => Task(
        name: json['name'],
        dueDate: json['dueDate'],
      );
}

class TaskPreferences {
  static const _keyTasks = 'tasks';

  static Future<void> saveTasks(List<Task> tasks) async {
    final prefs = await SharedPreferences.getInstance();
    final taskList = tasks.map((task) => jsonEncode(task.toJson())).toList();
    await prefs.setStringList(_keyTasks, taskList);
  }

  static Future<List<Task>> loadTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final taskList = prefs.getStringList(_keyTasks) ?? [];
    return taskList.map((task) => Task.fromJson(jsonDecode(task))).toList();
  }
}
