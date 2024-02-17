import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:alarm/addAlarm.dart';
import 'package:alarm/alarmRing.dart';
import 'package:alarm/alarmsList.dart';
import 'package:alarm/settings.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:alarm/util/notificationUtil.dart';
import 'homepage.dart';

FlutterLocalNotificationsPlugin localNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future onSelectNotification(String payload) async {
  await Navigator.push(
    MyApp.navigatorKey.currentState!.context,
    MaterialPageRoute<void>(
      builder: (BuildContext context) => AlarmRingPage(payload: payload),
    ),
  );
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await initializeNotifications();
  tz.initializeTimeZones();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static final navigatorKey = new GlobalKey<NavigatorState>();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Alarm',
      home: HomePage(
        title: 'Flutter Alarm',
      ),
      initialRoute: '/',
      routes: {
        '/alarms': (context) => AlarmsListPage(),
        '/addAlarm': (context) => AddAlarmPage(),
        '/settings': (context) => SettingsPage(),
        '/ring': (context) => AlarmRingPage(
              payload: '',
            )
      },
      navigatorKey: navigatorKey,
      theme: ThemeData(
        fontFamily: 'JosefinSans',
      ),
    );
  }
}
