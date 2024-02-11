import 'package:home_info/core/request_result/request_result.dart';

import '../../data/model/reminder_model.dart';
import '../entities/reminder_entity.dart';

abstract class ReminderDBRepository {
  Future<RequestResult<List<ReminderModel>>> fetchNotification();
  Future<RequestResult<ReminderEntity>> createNotification(ReminderEntity reminder);
  Future<RequestResult<String>> deleteReminder(String id);
}