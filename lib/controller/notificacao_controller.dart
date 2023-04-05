import 'package:get/get.dart';
import 'package:workmanager/workmanager.dart';

import '../services/notifi_service.dart';

class NotificacaoController extends GetxController{
  Rx<DateTime>? procedimentoTime;
  
  callbackDispatcher() {
  Workmanager().executeTask((task, inputData) {
    if(DateTime.now().hour == procedimentoTime!.value.hour && DateTime.now().day == procedimentoTime!.value.day){
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

}