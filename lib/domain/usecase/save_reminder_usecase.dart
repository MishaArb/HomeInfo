import 'package:home_info/core/usecase/usecase.dart';

import '../../core/request_result/request_result.dart';
import '../entities/reminder_entity.dart';
import '../repository/reminder_db_repository.dart';

class SaveReminderUseCase implements UseCase<RequestResult<ReminderEntity>, ReminderEntity> {
  SaveReminderUseCase(this.reminderDBRepository);
  final ReminderDBRepository reminderDBRepository;


  @override
  Future<RequestResult<ReminderEntity>> call({ReminderEntity? params}) async {
     return await reminderDBRepository.createNewReminder(params!);
  }
}
