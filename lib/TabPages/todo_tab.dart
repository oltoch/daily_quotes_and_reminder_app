import 'package:daily_quotes_and_reminder_app/DataHandler/app_data.dart';
import 'package:daily_quotes_and_reminder_app/Models/task_data.dart';
import 'package:daily_quotes_and_reminder_app/Screens/add_task_screen.dart';
import 'package:daily_quotes_and_reminder_app/Utils/boxes.dart';
import 'package:daily_quotes_and_reminder_app/Utils/constants.dart';
import 'package:daily_quotes_and_reminder_app/Widgets/box_value_listenable_builder.dart';
import 'package:daily_quotes_and_reminder_app/Widgets/task_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class TodoTab extends StatefulWidget {
  @override
  State<TodoTab> createState() => _TodoTabState();
}

class _TodoTabState extends State<TodoTab> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
            //backgroundColor: Colors.lightBlueAccent,
            child: Icon(Icons.add, size: 36, color: Color(0xfff50057)),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
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
              padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Icon(
                          Icons.list_alt_outlined,
                          size: 40,
                          color: Color(0xfff50057),
                        ),
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          //color: Color(0xffff4081),
                          borderRadius: BorderRadius.circular(
                            10.0,
                          ),
                        ),
                      ),
                      Container(
                        child: Row(
                          children: [
                            PopupMenuButton<int>(
                              onSelected: (item) =>
                                  onFilterItemSelected(context, item),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0)),
                              icon: Icon(Icons.filter_list,
                                  size: 40, color: Colors.white
                                  //color: Color(0xffff4081),
                                  ),
                              itemBuilder: (context) => [
                                PopupMenuItem<int>(
                                  value: 0,
                                  child: Text('Show all'),
                                ),
                                PopupMenuItem<int>(
                                  value: 1,
                                  child: Text('Completed'),
                                ),
                                PopupMenuItem<int>(
                                  value: 2,
                                  child: Text('In Progress'),
                                ),
                              ],
                            ),
                            SizedBox(width: 20),
                            PopupMenuButton(
                              icon: Icon(Icons.settings,
                                  size: 40, color: Colors.white),
                              itemBuilder: (context) => [
                                PopupMenuItem(
                                  child: Row(
                                    children: [
                                      Icon(Icons.logout_outlined),
                                      SizedBox(width: 2),
                                      Text('Exit'),
                                    ],
                                  ),
                                  onTap: () {
                                    SystemNavigator.pop();
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    'My ToDo',
                    style: kTabLabelTextStyle,
                  ),
                  TaskText(),
                ],
              ),
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  //color: Color(0xff8eacbb),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    topRight: Radius.circular(20.0),
                  ),
                ),
                child: Consumer<AppData>(
                  builder: (context, appData, child) {
                    return BoxValueListenableBuilder(
                        value: Provider.of<AppData>(context, listen: false)
                            .data
                            .filterValue);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  onFilterItemSelected(BuildContext context, int item) {
    final box = Boxes.getTaskData().values;
    switch (item) {
      case 0:
        Provider.of<AppData>(context, listen: false)
            .updateTileDataFilterValue(0);
        int a = box.toList().cast<TaskData>().length;
        Provider.of<AppData>(context, listen: false).updateTileDataTotalTask(a);

        break;
      case 1:
        Provider.of<AppData>(context, listen: false)
            .updateTileDataFilterValue(1);
        int a = box.toList().where((element) {
          return element.isCompleted ? true : false;
        }).length;
        Provider.of<AppData>(context, listen: false).updateTileDataTotalTask(a);
        break;
      default:
        Provider.of<AppData>(context, listen: false)
            .updateTileDataFilterValue(2);
        int a = box.toList().where((element) {
          return !element.isCompleted ? true : false;
        }).length;
        Provider.of<AppData>(context, listen: false).updateTileDataTotalTask(a);
        break;
    }
  }
}
