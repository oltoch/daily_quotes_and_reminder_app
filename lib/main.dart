import 'package:daily_quotes_and_reminder_app/Notification/notification_api.dart';
import 'package:daily_quotes_and_reminder_app/Screens/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:timezone/data/latest.dart' as tz;

import 'DataHandler/app_data.dart';
import 'Models/note_data.dart';
import 'Models/task_data.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(TaskDataAdapter());
  Hive.registerAdapter(NoteDataAdapter());
  await Hive.openBox<TaskData>('task_data');
  await Hive.openBox<NoteData>('note_data');
  tz.initializeTimeZones();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AppData(),
      child: MaterialApp(
        title: 'Motivate Me!',
        theme: ThemeData.light().copyWith(
          floatingActionButtonTheme: FloatingActionButtonThemeData(
            backgroundColor: Colors.grey[200],
            elevation: 4,
            sizeConstraints: BoxConstraints.tightFor(
              width: 65,
              height: 65,
            ),
          ),
          bottomNavigationBarTheme: BottomNavigationBarThemeData(
              selectedIconTheme: IconThemeData(size: 28.0),
              unselectedIconTheme: IconThemeData(size: 22.0),
              selectedItemColor: Color(0xfff50057),
              unselectedItemColor: Color(0xff64b5f6),
              //unselectedItemColor: Color(0xff607d8b),
              selectedLabelStyle: TextStyle(fontSize: 16.0),
              unselectedLabelStyle: TextStyle(fontSize: 13.0)),
          scaffoldBackgroundColor: Color(0xff2979ff),
          //scaffoldBackgroundColor: Color(0xff34515e),ff4081
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

  @override
  void initState() {
    super.initState();
    NotificationApi.init(initScheduled: true);
    listenNotifications();
  }

  void listenNotifications() =>
      NotificationApi.onNotifications.stream.listen(onCLickedNotification);

  void onCLickedNotification(String? payload) {
    // Navigator.push(context,
    //     MaterialPageRoute(builder: (context) => MainScreen(payload: payload)));
  }
}
