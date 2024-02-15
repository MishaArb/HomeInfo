import '../../core/usecase/usecase.dart';
import '../repository/local_notification_repository.dart';

class DeleteLocalNotificationUseCase implements UseCase<void, int> {
  DeleteLocalNotificationUseCase(this._localNotification);
  final LocalNotificationRepository  _localNotification;


  @override
  Future<void> call({int? params}) async {
    return await _localNotification.deleteNotification(params!);
  }
}