
import '../../core/usecase/usecase.dart';
import '../../data/model/local_notification_model.dart';
import '../repository/local_notification_repository.dart';

class SetLocalNotificationUseCase implements UseCase<void, LocalNotificationModel> {
  SetLocalNotificationUseCase(this._localNotification);
  final LocalNotificationRepository  _localNotification;


  @override
  Future<void> call({LocalNotificationModel? params}) async {
    return await _localNotification.setScheduleNotification(params!);
  }
}