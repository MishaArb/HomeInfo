import '../../data/model/local_notification_model.dart';

abstract interface class LocalNotificationRepository{
  Future<void> setScheduleNotification(LocalNotificationModel localNotificationModel);
  Future<void> deleteNotification(int id);
}