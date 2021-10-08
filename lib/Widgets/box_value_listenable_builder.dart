import 'package:daily_quotes_and_reminder_app/Models/task_data.dart';
import 'package:daily_quotes_and_reminder_app/Utils/boxes.dart';
import 'package:daily_quotes_and_reminder_app/Widgets/task_tile.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class BoxValueListenableBuilder extends StatelessWidget {
  const BoxValueListenableBuilder({
    Key? key,
    required this.value,
  }) : super(key: key);
  final int value;
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Box<TaskData>>(
      valueListenable: Boxes.getTaskData().listenable(),
      builder: (context, box, _) {
        var taskDataList;
        if (value == 0) {
          taskDataList = box.values.toList().cast<TaskData>();
        } else if (value == 1) {
          taskDataList = box.values
              .toList()
              .where((element) {
                return element.isCompleted ? true : false;
              })
              .toList()
              .cast<TaskData>();
        } else {
          taskDataList = box.values
              .toList()
              .where((element) {
                return !element.isCompleted ? true : false;
              })
              .toList()
              .cast<TaskData>();
        }
        return TaskTile(taskData: taskDataList);
      },
    );
  }
}
