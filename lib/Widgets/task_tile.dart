import 'package:daily_quotes_and_reminder_app/Models/task_data.dart';
import 'package:daily_quotes_and_reminder_app/Screens/add_task_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'delete_dialog_box.dart';

class TaskTile extends StatefulWidget {
  final List<TaskData> taskData;
  const TaskTile({Key? key, required this.taskData}) : super(key: key);

  @override
  State<TaskTile> createState() => _TaskTileState();
}

class _TaskTileState extends State<TaskTile> {
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
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(8),
              itemCount: widget.taskData.length,
              itemBuilder: (BuildContext context, int index) {
                final taskData = widget.taskData[index];
                return buildTask(context, taskData);
              },
            ),
          ),
        ],
      );
    }
  }

  Widget buildTask(context, TaskData taskData) {
    final dateStarted = DateFormat.yMMMd().format(taskData.dateStarted);
    return Card(
      elevation: 3,
      shape: BeveledRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      color: Color(0xff829EAC),
      child: ExpansionTile(
        iconColor: Colors.white,
        collapsedTextColor: Colors.black,
        textColor: Colors.white,
        collapsedIconColor: Colors.black,
        tilePadding: EdgeInsets.symmetric(horizontal: 14, vertical: 2),
        title: Text(
          taskData.title,
          softWrap: true,
          maxLines: 5,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        subtitle: Text(
          'Created: ' + dateStarted,
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
        children: [
          buildButtons(context, taskData),
        ],
      ),
    );
  }

  Widget buildButtons(BuildContext context, TaskData taskData) {
    return Row(
      children: [
        Expanded(
          child: TextButton.icon(
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
                              bottom: MediaQuery.of(context).viewInsets.bottom),
                          child: AddTaskScreen(true, taskData, context),
                        )));
              }),
        ),
        Expanded(
          child: TextButton.icon(
            label: Text(
              'Delete',
              style: TextStyle(color: Colors.white),
            ),
            icon: Icon(Icons.delete, color: Colors.white),
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return DeleteDialogBox(taskData);
                  },
                  barrierDismissible: false);
            },
          ),
        )
      ],
    );
  }
}
