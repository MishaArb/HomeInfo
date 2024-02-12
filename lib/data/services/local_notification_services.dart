import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;

import '../model/local_notification_model.dart';

class LocalNotificationService {
  LocalNotificationService(){
    initNotification();
  }

  final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> initNotification() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);

    _notificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse:
            (NotificationResponse notificationResponse)  {});

    _notificationsPlugin.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()?.requestNotificationsPermission();
  }

  _notificationDetails() async {
    return const NotificationDetails(
      android: AndroidNotificationDetails('channelId', 'channelName',
          importance: Importance.max,
      ),
    );
  }

  Future<void> showScheduleNotification(
      LocalNotificationModel localNotificationModel) async {
    await _notificationsPlugin.zonedSchedule(
      localNotificationModel.id,
      localNotificationModel.title,
      localNotificationModel.body,
      tz.TZDateTime.from(
          DateTime.parse(localNotificationModel.scheduleDateTime), tz.local),
      await _notificationDetails(),
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: localNotificationModel.isRepeat
          ? DateTimeComponents.dayOfMonthAndTime
          : null,
    );
  }

  void cancelNotification(int id){
    _notificationsPlugin.cancel(id);
  }

}
