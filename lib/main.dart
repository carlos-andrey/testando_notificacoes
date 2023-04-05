import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:notificacoes/services/notifi_service.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:workmanager/workmanager.dart';

import 'home_page.dart'; 

callbackDispatcher() async{
  final prefs = await SharedPreferences.getInstance();
  
  Workmanager().executeTask((task, inputData) {
    if(DateTime.now().hour == DateTime.parse(jsonDecode(prefs.getString('procedimentoTime')!)['data']).hour){
      NotificationService().showNotification(
        id: 1, 
        title: 'title', 
        body: 'body', 
        payload: 'payload'
      );
    }
    return Future.value(true);
  });
}

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  NotificationService().initNotification();
  tz.initializeTimeZones();
  await Permission.notification.isDenied.then((value) {
    if (value) {
      Permission.notification.request();
    }
  });
 Workmanager().initialize(
     
      // The top level function, aka callbackDispatcher
      callbackDispatcher,
     
      // If enabled it will post a notification whenever
      // the task is running. Handy for debugging tasks
      isInDebugMode: true
  );
  // Periodic task registration
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Notifications',
      theme: ThemeData(
        primarySwatch: Colors.blue
      ),
      home: const HomePage(),
    );
  }
}
