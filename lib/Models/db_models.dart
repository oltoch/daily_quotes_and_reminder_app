import 'package:daily_quotes_and_reminder_app/Models/note_data.dart';
import 'package:daily_quotes_and_reminder_app/Utils/boxes.dart';

import 'task_data.dart';

class DbModels {
  static Future<void> addTask(
      {required int key,
      required String title,
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
    //await box.add(taskData);
    await box.put(key, taskData);
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
    // final box = Boxes.getTaskData();
    // box.delete(taskData.key);
    taskData.delete();
  }

  static Future<void> addNote(
      {required String title,
      required String note,
      required DateTime date,
      required String time}) async {
    final noteData = NoteData();
    noteData.title = title;
    noteData.time = time;
    noteData.date = date;
    noteData.note = note;

    final box = Boxes.getNoteData();
    await box.add(noteData);
  }

  static Future<void> editNote(
      {required NoteData noteData,
      required String title,
      required String note,
      required DateTime date,
      required String time}) async {
    noteData.title = title;
    noteData.time = time;
    noteData.date = date;
    noteData.note = note;

    await noteData.save();
  }

  static void deleteNote({required NoteData noteData}) {
    noteData.delete();
  }
}
