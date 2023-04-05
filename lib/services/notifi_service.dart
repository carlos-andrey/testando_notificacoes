import 'dart:convert';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:workmanager/workmanager.dart';

class NotificationService{
  final FlutterLocalNotificationsPlugin notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> initNotification() async {
    AndroidInitializationSettings androidInitializationSettings = const AndroidInitializationSettings(
      'flutter_logo'
    );
  
    var initializationSettings = InitializationSettings(
      android: androidInitializationSettings
    );
    
    await notificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse notificationResponse) async{}
    );
  }

  notificationDetails(){
    return const NotificationDetails(
      android: AndroidNotificationDetails(
        'channelId',
        'channelName',
        importance: Importance.max
      )
    );
  }

  Future showNotification(
    {
    required int id, 
    required String? title, 
    required String? body, 
    required String? payload,}) async {
      return notificationsPlugin.show(id, title, body, await notificationDetails());
    }

  Future scheduleNotification(
    {
    required int id, 
    required String? title, 
    required String? body, 
    required String? payload,
    required DateTime scheduleNotificationDateTime}) async {
      return notificationsPlugin.zonedSchedule(
        id,
        title,
        body,
        tz.TZDateTime.from(
          scheduleNotificationDateTime,
          tz.local
        ),
        await notificationDetails(),
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime
      );
    }  
}