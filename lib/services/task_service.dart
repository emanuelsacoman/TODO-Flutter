import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/task_model.dart';

class TaskService {
  //salva as tarefas
  Future<void> saveTask(
      String title, String description, bool isDone, String priority) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> tasks = prefs.getStringList('tasks') ?? [];
    Task task =
        Task(title: title, description: description, priority: priority);
    tasks.add(jsonEncode(task.tojson()));
    await prefs.setStringList('tasks', tasks);
    print('Tarefa salva');
  }

  //recupera as tarefas
  getTasks() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> tasksString = prefs.getStringList('tasks') ?? [];
    List<Task> tasks = tasksString
        .map((taskJson) => Task.fromJson(jsonDecode(taskJson)))
        .toList();
    return tasks;
  }

  deleteTask(int index) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> tasks = prefs.getStringList('tasks') ?? [];
    tasks.removeAt(index);
    await prefs.setStringList('tasks', tasks);
    print('Tarefa deletada');
  }

  editTask(int index, String title, String description, bool isDone, String priority) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> tasks = prefs.getStringList('tasks') ?? [];
    Task updatedTask =
        Task(title: title, description: description, isDone: isDone,priority: priority);
    tasks[index] = jsonEncode(updatedTask.tojson());
    await prefs.setStringList('tasks', tasks);
  }

  editTaskByCheckBox(int index, bool isDone) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> tasks = prefs.getStringList('tasks') ?? [];
    Task existingTask = Task.fromJson(jsonDecode(tasks[index]));
    existingTask.isDone = isDone;
    tasks[index] = jsonEncode(existingTask.tojson());
    await prefs.setStringList('tasks', tasks);
    print('Editou isDone');
  }
}