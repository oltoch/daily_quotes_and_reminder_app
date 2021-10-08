import 'package:daily_quotes_and_reminder_app/DataHandler/app_data.dart';
import 'package:daily_quotes_and_reminder_app/Models/task_data.dart';
import 'package:daily_quotes_and_reminder_app/Notification/notification_api.dart';
import 'package:daily_quotes_and_reminder_app/Screens/add_task_screen.dart';
import 'package:daily_quotes_and_reminder_app/Utils/boxes.dart';
import 'package:daily_quotes_and_reminder_app/Widgets/completed_dialog_box.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'delete_dialog_box.dart';

class TaskTile extends StatefulWidget {
  final List<TaskData> taskData;
  const TaskTile({Key? key, required this.taskData}) : super(key: key);

  @override
  State<TaskTile> createState() => _TaskTileState();
}

class _TaskTileState extends State<TaskTile> {
  final listKey = GlobalKey<AnimatedListState>();
  @override
  Widget build(BuildContext context) {
    if (widget.taskData.isEmpty) {
      return Center(
        child: Text(
          'No tasks yet!',
          style: TextStyle(fontSize: 24),
        ),
      );
    } else {
      return Column(
        children: [
          SizedBox(height: 10),
          // AnimatedList(
          //     key: listKey,
          //     initialItemCount: widget.taskData.length,
          //     itemBuilder: (context, index, animation) {}),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(8),
              itemCount: widget.taskData.length,
              itemBuilder: (BuildContext context, int index) {
                widget.taskData
                    .sort((a, b) => a.dateStarted.compareTo(b.dateStarted));
                final taskData = widget.taskData[index];
                return buildTask(context, taskData, index);
              },
            ),
          ),
        ],
      );
    }
  }

  Widget buildTask(context, TaskData taskData, int index) {
    Color color = index.isOdd ? Color(0xffff4081) : Color(0xff448aff);
    final dateExpected = DateFormat.MMMd().format(taskData.dateExpected);
    var dateCompleted;
    if (taskData.isCompleted) {
      dateCompleted = DateFormat.yMMMd().format(taskData.dateCompleted!);
    }
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      color: color,
      //color: Color(0xff829EAC),
      child: GestureDetector(
        onLongPress: () {
          showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return CompletedDialogBox(taskData);
                  },
                  barrierDismissible: false)
              .then((value) {
            if (value == 'yes') {
              NotificationApi.cancelNotification(taskData.key);
              final box = Boxes.getTaskData().values;
              int count;
              int a =
                  Provider.of<AppData>(context, listen: false).data.filterValue;
              if (a == 0) {
                count = box.toList().length;
              } else if (a == 1) {
                count = box.toList().where((element) {
                  return element.isCompleted ? true : false;
                }).length;
              } else {
                count = box.toList().where((element) {
                  return !element.isCompleted ? true : false;
                }).length;
              }
              Provider.of<AppData>(context, listen: false)
                  .updateTileDataTotalTask(count);
            }
          });
        },
        child: ExpansionTile(
          iconColor: Colors.white,
          collapsedTextColor: Colors.white,
          textColor: Colors.white,
          collapsedIconColor: Colors.white,
          tilePadding: EdgeInsets.symmetric(horizontal: 14, vertical: 2),
          title: Text(
            taskData.title,
            softWrap: true,
            maxLines: 5,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          subtitle: Text(
            !taskData.isCompleted
                ? 'Deadline: ' + dateExpected
                : 'Completed: ' + dateCompleted,
            style: TextStyle(fontWeight: FontWeight.w500),
          ),
          children: [
            buildButtons(context, taskData),
          ],
        ),
      ),
    );
  }

  Widget buildButtons(BuildContext context, TaskData taskData) {
    final dateStarted = DateFormat.MMMd().format(taskData.dateStarted);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Created: ' + dateStarted,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
          ),
          SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton.icon(
                  label: Text(
                    'Edit',
                    style: TextStyle(color: Colors.white),
                  ),
                  icon: Icon(Icons.edit, color: Colors.white),
                  onPressed: () {
                    showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        builder: (context) => SingleChildScrollView(
                                child: Container(
                              padding: EdgeInsets.only(
                                  bottom:
                                      MediaQuery.of(context).viewInsets.bottom),
                              child: AddTaskScreen(true, taskData, context),
                            )));
                  }),
              TextButton.icon(
                label: Text(
                  'Delete',
                  style: TextStyle(color: Colors.white),
                ),
                icon: Icon(Icons.delete, color: Colors.white),
                onPressed: () {
                  showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return DeleteDialogBox(true, taskData: taskData);
                          },
                          barrierDismissible: false)
                      .then((value) {
                    if (value == 'yes') {
                      final box = Boxes.getTaskData().values;
                      int count;
                      int a = Provider.of<AppData>(context, listen: false)
                          .data
                          .filterValue;
                      if (a == 0) {
                        count = box.toList().length;
                      } else if (a == 1) {
                        count = box.toList().where((element) {
                          return element.isCompleted ? true : false;
                        }).length;
                      } else {
                        count = box.toList().where((element) {
                          return !element.isCompleted ? true : false;
                        }).length;
                      }
                      Provider.of<AppData>(context, listen: false)
                          .updateTileDataTotalTask(count);
                      int countActive = box.toList().where((element) {
                        return !element.isCompleted ? true : false;
                      }).length;
                      if (countActive == 0) {
                        NotificationApi.cancelNotification(0);
                      }
                    }
                  });
                },
              )
            ],
          ),
        ],
      ),
    );
  }
}
