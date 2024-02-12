import '../../core/usecase/usecase.dart';
import '../../data/repository/local_notification_repository_imp.dart';

class DeleteLocalNotificationUseCase implements UseCase<void, int> {
  DeleteLocalNotificationUseCase(this._localNotification);
  final LocalNotificationRepositoryImpl  _localNotification;


  @override
  Future<void> call({int? params}) async {
    return await _localNotification.deleteNotification(params!);
  }
}