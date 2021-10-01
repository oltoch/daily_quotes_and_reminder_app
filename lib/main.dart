import 'package:daily_quotes_and_reminder_app/Screens/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

import 'DataHandler/app_data.dart';
import 'Models/task_data.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(TaskDataAdapter());
  await Hive.openBox<TaskData>('task_data');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AppData(),
      child: MaterialApp(
        title: 'Motivate Me!',
        theme: ThemeData.dark().copyWith(
          floatingActionButtonTheme: FloatingActionButtonThemeData(
            backgroundColor: Colors.lime,
          ),
          bottomNavigationBarTheme: BottomNavigationBarThemeData(
              selectedIconTheme: IconThemeData(size: 28.0),
              unselectedIconTheme: IconThemeData(size: 22.0),
              selectedItemColor: Colors.lime,
              unselectedItemColor: Color(0xff607d8b),
              selectedLabelStyle: TextStyle(fontSize: 16.0),
              unselectedLabelStyle: TextStyle(fontSize: 13.0)),
          scaffoldBackgroundColor: Color(0xff34515e),
        ),

        //home: MainScreen(),
        initialRoute: MainScreen.id,
        routes: {
          MainScreen.id: (context) => MainScreen(),
        },
        debugShowCheckedModeBanner: false,
        builder: EasyLoading.init(),
      ),
    );
  }
}
