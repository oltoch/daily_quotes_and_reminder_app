import 'package:daily_quotes_and_reminder_app/TabPages/motivation_tab.dart';
import 'package:daily_quotes_and_reminder_app/TabPages/notes_tab.dart';
import 'package:daily_quotes_and_reminder_app/TabPages/todo_tab.dart';
import 'package:daily_quotes_and_reminder_app/TabPages/weather_tab.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class MainScreen extends StatefulWidget {
  static const String id = 'MainScreen';

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(),
      body: TabBarView(
        physics: NeverScrollableScrollPhysics(),
        controller: tabController,
        children: [
          TodoTab(),
          NotesTab(),
          MotivationTab(),
          WeatherTab(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.list_alt_outlined), label: 'ToDo'),
          BottomNavigationBarItem(
              icon: Icon(Icons.sticky_note_2_outlined), label: 'Notes'),
          BottomNavigationBarItem(
              icon: Icon(Icons.book_outlined), label: 'Quotes'),
          BottomNavigationBarItem(
              icon: Icon(Icons.cloud_outlined), label: 'Weather'),
        ],
        elevation: 16,
        showUnselectedLabels: true,
        currentIndex: selectedIndex,
        onTap: onItemCLicked,
        // unselectedItemColor: Colors.green[300],
        // selectedItemColor: Colors.green[900],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    tabController.dispose();
    Hive.box('task_data').close(); //to close a particular box
    //Hive.close(); //to close all boxes
  }

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 4, vsync: this);
  }

  void onItemCLicked(int index) {
    setState(() {
      selectedIndex = index;
      tabController.index = selectedIndex;
    });
  }
}
