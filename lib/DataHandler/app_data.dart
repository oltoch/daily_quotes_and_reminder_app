import 'package:daily_quotes_and_reminder_app/DataHandler/task_tile_data.dart';
import 'package:daily_quotes_and_reminder_app/Models/task_data.dart';
import 'package:flutter/material.dart';

class AppData extends ChangeNotifier {
  List<TaskData> tasks = [];
  TaskTileData data = TaskTileData();
  TaskData taskData = TaskData();

  void updateTaskList(TaskData taskData) {
    tasks.add(taskData);
    notifyListeners();
  }

  void updateTileData(bool value) {
    data.isChecked = value;
    notifyListeners();
  }

  void updateTaskData(TaskData data) {
    taskData = data;
    notifyListeners();
  }
}
