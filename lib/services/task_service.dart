import 'dart:convert';

import 'package:aula1/models/task_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TaskService {

  Future<void> saveTask(String title, String description, bool isDone) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> tasks = prefs.getStringList('tasks') ?? [];
    Task task = Task(title: title, description: description);
    tasks.add(jsonEncode(task.toJson()));
    await prefs.setStringList('tasks', tasks);
  }

  getTasks() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> tasksString = prefs.getStringList('tasks') ?? [];
    List<Task> tasks = tasksString.map((taskJson) => Task.fromJson(jsonDecode(taskJson))).toList();
    return tasks;
  
  }

  deleteTask(int index) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> tasks = prefs.getStringList('tasks') ?? [];
    tasks.removeAt(index);
    await prefs.setStringList('tasks', tasks);
  }

  editTask(int index, String title, String description, bool isDone) async{
    SharedPreferences prefs  = await SharedPreferences.getInstance();
    List<String> tasks = prefs.getStringList('tasks') ?? [];
    Task updatedTask = Task(title: title, description: description);
    tasks[index] = jsonEncode(updatedTask.toJson());
    await prefs.setStringList('tasks', tasks);
  }

  editBoolTask(bool isDone) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> tasks = prefs.getStringList('tasks') ?? [];
    
  }
}