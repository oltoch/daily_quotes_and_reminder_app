import 'package:hive/hive.dart';

part 'note_data.g.dart';

@HiveType(typeId: 1)
class NoteData extends HiveObject {
  @HiveField(0)
  late String title;

  @HiveField(1)
  late String note;

  @HiveField(2)
  late DateTime date;

  @HiveField(3)
  late String time;
}
