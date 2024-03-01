import 'package:home_info/core/request_result/request_result.dart';

import 'package:home_info/data/model/reminder_model.dart';

import '../../domain/entities/reminder_entity.dart';
import '../../domain/repository/reminder_db_repository.dart';
import '../data_sources/sqflite_db.dart';

class ReminderDBRepositoryImpl implements ReminderDBRepository {
  ReminderDBRepositoryImpl(this.db);

  final SQfliteDB db;

  @override
  Future<RequestResult<List<ReminderModel>>> fetchReminders() async {
    try {
      final allReminders = await db.getAllReminders();
      return RequestSuccess(allReminders);
    } catch (e) {
      return RequestError(e.toString());
    }
  }

  @override
  Future<RequestResult<ReminderEntity>> createNewReminder(
      ReminderEntity reminder) async {
    try {
      await db.createNewReminder(ReminderModel.fromEntity(reminder) );
      return RequestSuccess(reminder);
    } catch (e) {
      return RequestError(e.toString());
    }
  }

  @override
  Future<RequestResult<String>> deleteReminder(String id) async {
    try {
      await db.deleteReminder(id);
      return RequestSuccess(id);
    } catch (e) {
      return RequestError(e.toString());
    }
  }
}
