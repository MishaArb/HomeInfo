import '../../domain/repository/local_notification_repository.dart';
import '../model/local_notification_model.dart';
import '../services/local_notification_services.dart';

class LocalNotificationRepositoryImpl implements LocalNotificationRepository {
  LocalNotificationRepositoryImpl(this._notificationService);

  final LocalNotificationService _notificationService;

  @override
  Future<void> setScheduleNotification(LocalNotificationModel localNotificationModel) async {
   await _notificationService.showScheduleNotification(localNotificationModel);
  }

  @override
  Future<void> deleteNotification(int id) async{
   _notificationService.cancelNotification(id);
  }
}
