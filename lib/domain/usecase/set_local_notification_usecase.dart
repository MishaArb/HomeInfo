
import '../../core/usecase/usecase.dart';
import '../../data/model/local_notification_model.dart';
import '../../data/repository/local_notification_repository_imp.dart';

class SetLocalNotificationUseCase implements UseCase<void, LocalNotificationModel> {
  SetLocalNotificationUseCase(this._localNotification);
  final LocalNotificationRepositoryImpl  _localNotification;


  @override
  Future<void> call({LocalNotificationModel? params}) async {
    return await _localNotification.setScheduleNotification(params!);
  }
}