import 'package:home_info/core/request_result/request_result.dart';

import '../../data/model/reminder_model.dart';
import '../entities/reminder_entity.dart';

abstract interface class ReminderDBRepository {
  Future<RequestResult<List<ReminderModel>>> fetchReminders();
  Future<RequestResult<ReminderEntity>> createNewReminder(ReminderEntity reminder);
  Future<RequestResult<String>> deleteReminder(String id);
}