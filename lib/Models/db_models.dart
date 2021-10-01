import 'package:daily_quotes_and_reminder_app/Utils/boxes.dart';

import 'task_data.dart';

class DbModels {
  static Future<void> addTask(
      {required String title,
      required DateTime dateExpected,
      required DateTime? dateCompleted,
      required String timeExpected,
      required String? timeCompleted,
      required bool isAlarmOn,
      required bool isCompleted}) async {
    final taskData = TaskData();
    taskData.title = title;
    taskData.timeCompleted = timeCompleted;
    taskData.timeExpected = timeExpected;
    taskData.dateCompleted = dateCompleted;
    taskData.dateExpected = dateExpected;
    taskData.isCompleted = isCompleted;
    taskData.isAlarmOn = isAlarmOn;

    final box = Boxes.getTaskData();
    await box.add(taskData);
    //box.put(key, value);
  }

  static Future<void> editTask(TaskData taskData,
      {required String title,
      required DateTime dateExpected,
      required DateTime? dateCompleted,
      required String timeExpected,
      required String? timeCompleted,
      required bool isAlarmOn,
      required bool isCompleted}) async {
    taskData.title = title;
    taskData.timeCompleted = timeCompleted;
    taskData.timeExpected = timeExpected;
    taskData.dateCompleted = dateCompleted;
    taskData.dateExpected = dateExpected;
    taskData.isCompleted = isCompleted;
    taskData.isAlarmOn = isAlarmOn;
    //final box = Boxes.getTaskData();
    // await box.put(taskData.key, taskData);

    await taskData.save();
  }

  static void deleteTask(TaskData taskData) {
    // final box = Boxes.getTransactions();
    // box.delete(transaction.key);
    taskData.delete();
  }
}
