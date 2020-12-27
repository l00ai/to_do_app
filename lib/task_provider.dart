import 'package:flutter/widgets.dart';

import 'db.helper.dart';
import 'task_model.dart';

class TaskProvider with ChangeNotifier {
  bool isInit = false;
  List<Task> tasksLast;
  List<Task> get tasks => [...tasksLast];

  TaskProvider() {
    getAllTasks();
  }

  Future<List<Task>> getAllTasks() async {
    final data = await DBHelper.dbHelper.selectAllTask();
    tasksLast = data;
    isInit = true;
    notifyListeners();
    return data;
  }

  void deleteTask(Task task) {
    DBHelper.dbHelper.deleteTask(task);
    getAllTasks();
  }

  void updateTask(Task task) {
    DBHelper.dbHelper.updateTask(task);
    getAllTasks();
  }

  void insertNewTask(Task task) {
    DBHelper.dbHelper.insertNewTask(task);
    getAllTasks();
  }

}
