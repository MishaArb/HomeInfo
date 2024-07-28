import '../../core/request_result/request_result.dart';
import '../../core/usecase/usecase.dart';
import '../repository/backup_restore_db_repository.dart';

class RestoreDbUserCase implements UseCase<void, Future<RequestResult<void>>> {
  RestoreDbUserCase(this._restoreDB);
  final BackupRestoreDBRepository  _restoreDB;


  @override
  Future<RequestResult<void>> call({void params}) async {
    return await _restoreDB.restoreDB();
  }
}