import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:rxdart/rxdart.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationApi {
  static final _notifications = FlutterLocalNotificationsPlugin();
  static final onNotifications = BehaviorSubject<String?>();

  static Future showNotification(
      {int id = 0, String? title, String? body, String? payLoad}) async {
    _notifications.show(id, title, body, await _notificationDetails(),
        payload: payLoad);
  }

  static Future showDailyNotification(
      {required int id, String? title, String? body, String? payLoad}) async {
    _notifications.zonedSchedule(id, title, body, _scheduleDaily(Time(9, 50)),
        await _notificationDetails(),
        payload: payLoad,
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.time);
  }

  static Future showScheduledNotification(
      {required int id,
      String? title,
      String? body,
      String? payLoad,
      required TimeOfDay scheduleTime,
      required DateTime scheduleDate}) async {
    _notifications.zonedSchedule(
        id,
        title,
        body,
        _scheduleNotification(time: scheduleTime, date: scheduleDate),
        await _notificationDetails(),
        payload: payLoad,
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.dateAndTime);
  }

  static Future cancelNotification(int id) async =>
      await _notifications.cancel(id);
  static Future cancelAllNotification() async =>
      await _notifications.cancelAll();

  static tz.TZDateTime _scheduleDaily(Time time) {
    final now = tz.TZDateTime.now(tz.local);
    final scheduleDate = tz.TZDateTime(tz.local, now.year, now.month, now.day,
        time.hour, time.minute, time.second);
    return scheduleDate.isBefore(now)
        ? scheduleDate.add(Duration(days: 1))
        : scheduleDate;
  }

  static tz.TZDateTime _scheduleNotification(
      {required TimeOfDay time, required DateTime date}) {
    final now = tz.TZDateTime.now(tz.local);
    final scheduleDate = tz.TZDateTime(
        tz.local, date.year, date.month, date.day, time.hour, time.minute);
    return scheduleDate.isBefore(now)
        ? scheduleDate.add(Duration(days: 1))
        : scheduleDate;
  }

  static Future _notificationDetails() async {
    return NotificationDetails(
      android: AndroidNotificationDetails(
        'channel id',
        'channel name',
        'channel description',
        importance: Importance.max,
      ),
      iOS: IOSNotificationDetails(),
    );
  }

  static Future init({bool initScheduled = false}) async {
    final android = AndroidInitializationSettings('@mipmap/ic_launcher');
    final iOS = IOSInitializationSettings();
    final initializationSettings =
        InitializationSettings(android: android, iOS: iOS);
    await _notifications.initialize(initializationSettings,
        onSelectNotification: (payload) async {
      onNotifications.add(payload);
    });

    if (initScheduled) {
      tz.initializeTimeZones();
      final locationName = await FlutterNativeTimezone.getLocalTimezone();
      tz.setLocalLocation(tz.getLocation(locationName));
    }
  }

  static Future showActiveNotifications() async {
    final List<ActiveNotification>? activeNotifications = await _notifications
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.getActiveNotifications();
    print(activeNotifications);
  }

  static Future showPendingNotifications() async {
    final List<PendingNotificationRequest> pendingNotificationRequests =
        await _notifications.pendingNotificationRequests();
    print(pendingNotificationRequests);
  }
}
