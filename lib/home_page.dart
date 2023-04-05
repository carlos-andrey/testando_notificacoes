import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:notificacoes/services/notifi_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workmanager/workmanager.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Titulo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              child: const Text('Mostra notificação'),
              onPressed: (){
                NotificationService().showNotification(
                  id: 1,
                  title: 'Teste', 
                  body: 'O corpo vai aqui', 
                  payload: 'Sei o que é isso não'
                );
              },
            ),
            DatePickerTxt(),
            ScheduleBnt()
          ],
        ),
      ),
    );
  }
}

class DatePickerTxt extends StatefulWidget {
  const DatePickerTxt({super.key});

  @override
  State<DatePickerTxt> createState() => _DatePickerTxtState();
}

class _DatePickerTxtState extends State<DatePickerTxt> {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        //var procedimentoTime = await jsonDecode(prefs.getString('procedimentoTime')!);
        DatePicker.showDateTimePicker(
          context,
          showTitleActions: true,
          //onChanged: ,
          onConfirm: (date) async {
            final prefs = await SharedPreferences.getInstance();
            await prefs.setString("procedimentoTime", jsonEncode({'data':date.toString()}));
            print(DateTime.parse(jsonDecode(prefs.getString('procedimentoTime')!)['data']));
              
          }
        );
      },
      child: const Text('Select DateTime'),
    );
  }
}

class ScheduleBnt extends StatelessWidget {
  const ScheduleBnt({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: const Text('Schedule notification'),
      onPressed: (){
        //debugPrint('Scheduled for $procedimentoTime');
        Workmanager().registerPeriodicTask(
          "2",
          //This is the value that will be
          //// returned in the callbackDispatcher
          "simplePeriodicTask",
          
          // When no frequency is provided
          // the default 15 minutes is set.
          // Minimum frequency is 15 min.
          // Android will automatically change
          // your frequency to 15 min
          // if you have configured a lower frequency.
          frequency: Duration(minutes: 15),
        );
      },
    );
  }
}