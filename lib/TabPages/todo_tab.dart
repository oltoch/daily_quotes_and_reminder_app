import 'package:daily_quotes_and_reminder_app/Models/task_data.dart';
import 'package:daily_quotes_and_reminder_app/Screens/add_task_screen.dart';
import 'package:daily_quotes_and_reminder_app/Utils/boxes.dart';
import 'package:daily_quotes_and_reminder_app/Widgets/task_tile.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class TodoTab extends StatefulWidget {
  @override
  State<TodoTab> createState() => _TodoTabState();
}

class _TodoTabState extends State<TodoTab> {
  bool isCheck = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
            //backgroundColor: Colors.lightBlueAccent,
            child: Icon(Icons.add),
            onPressed: () {
              showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  builder: (context) => SingleChildScrollView(
                          child: Container(
                        padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).viewInsets.bottom),
                        child: AddTaskScreen(false),
                      )));
            }),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.only(
                  top: 15.0, left: 20.0, right: 20.0, bottom: 15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Icon(
                          Icons.list_alt_outlined,
                          size: 30,
                          color: Colors.blueGrey[900],
                        ),
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          color: Colors.lime,
                          borderRadius: BorderRadius.circular(
                            10.0,
                          ),
                        ),
                      ),
                      Container(
                        child: Row(
                          children: [
                            Icon(Icons.filter_list,
                                size: 40, color: Colors.lime),
                            SizedBox(width: 20),
                            Icon(Icons.settings, size: 40, color: Colors.lime),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    'My To-do',
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                        color: Color(0xfffcfcfc),
                        fontSize: 40.0,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Text('Number of Tasks',
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                          color: Color(0xfffcfcfc),
                          fontSize: 18,
                        ),
                      )),
                ],
              ),
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                decoration: BoxDecoration(
                  color: Color(0xff8eacbb),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    topRight: Radius.circular(20.0),
                  ),
                ),
                child: ValueListenableBuilder<Box<TaskData>>(
                  valueListenable: Boxes.getTaskData().listenable(),
                  builder: (context, box, _) {
                    final taskData = box.values
                        // .where((element) {
                        //   //condition that mimics where clause in sql
                        //   //checks where element matches a condition
                        //   //return element.dateCompleted != null ? true : false;
                        //   return true;
                        // })
                        .toList()
                        .cast<TaskData>();
                    return TaskTile(taskData: taskData);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
