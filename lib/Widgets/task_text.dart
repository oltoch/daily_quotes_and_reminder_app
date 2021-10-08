import 'package:daily_quotes_and_reminder_app/DataHandler/app_data.dart';
import 'package:daily_quotes_and_reminder_app/Utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TaskText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AppData>(
      builder: (context, appData, child) {
        int total = appData.data.totalTask;
        int value = appData.data.filterValue;

        return value == 0
            ? Text(
                'All Tasks ($total)',
                style: kTaskStatusTextStyle,
              )
            : Text(
                '$total ${taskStatus(value)} ${isSingular(total)}',
                style: kTaskStatusTextStyle,
              );
      },
    );
  }

  String isSingular(int value) {
    return value == 1 ? 'Task' : 'Tasks';
  }

  String taskStatus(int value) {
    if (value == 1) {
      return 'Completed';
    } else
      return 'Running';
  }
}
