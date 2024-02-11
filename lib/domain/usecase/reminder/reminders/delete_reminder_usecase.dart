import '../../../../core/request_result/request_result.dart';
import '../../../../core/usecase/usecase.dart';
import '../../../repository/reminder_db_repository.dart';

class DeleteRemindersUseCase
    implements UseCase<RequestResult<String>, String> {
  DeleteRemindersUseCase(this.reminderDBRepository);

  final ReminderDBRepository reminderDBRepository;

  @override
  Future<RequestResult<String>> call({String? params}) async {
    return await reminderDBRepository.deleteReminder(params!);
  }
}
