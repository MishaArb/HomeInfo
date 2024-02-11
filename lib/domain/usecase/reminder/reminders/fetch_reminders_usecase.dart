import '../../../../core/request_result/request_result.dart';
import '../../../../core/usecase/usecase.dart';
import '../../../entities/reminder_entity.dart';
import '../../../repository/reminder_db_repository.dart';

class FetchRemindersUseCase
    implements UseCase<RequestResult<List<ReminderEntity>>, void> {
  FetchRemindersUseCase(this.reminderDBRepository);

  final ReminderDBRepository reminderDBRepository;

  @override
  Future<RequestResult<List<ReminderEntity>>> call({void params}) async {
    return await reminderDBRepository.fetchNotification();
  }
}
