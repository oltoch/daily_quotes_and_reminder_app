import 'package:daily_quotes_and_reminder_app/Models/note_data.dart';
import 'package:daily_quotes_and_reminder_app/Models/task_data.dart';
import 'package:hive/hive.dart';

class Boxes {
  static Box<TaskData> getTaskData() => Hive.box<TaskData>('task_data');
  static Box<NoteData> getNoteData() => Hive.box<NoteData>('note_data');
}
