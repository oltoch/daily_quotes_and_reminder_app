import 'package:daily_quotes_and_reminder_app/DataHandler/task_tile_data.dart';
import 'package:daily_quotes_and_reminder_app/Models/task_data.dart';
import 'package:daily_quotes_and_reminder_app/Utils/boxes.dart';
import 'package:flutter/material.dart';

class AppData extends ChangeNotifier {
  static int count = Boxes.getTaskData()
      .values
      .where((element) => element.isCompleted ? false : true)
      .length;
  List<TaskData> tasks = [];
  TaskTileData data = TaskTileData(totalTask: count);
  TaskData taskData = TaskData();

  void updateTaskList(TaskData taskData) {
    tasks.add(taskData);
    notifyListeners();
  }

  void updateTileDataTotalTask(int value) {
    data.totalTask = value;
    notifyListeners();
  }

  void updateTileDataFilterValue(int value) {
    data.filterValue = value;
    notifyListeners();
  }

  void updateTaskData(TaskData data) {
    taskData = data;
    notifyListeners();
  }
}
