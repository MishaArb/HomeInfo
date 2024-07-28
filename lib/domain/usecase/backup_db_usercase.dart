import '../../core/request_result/request_result.dart';
import '../../core/usecase/usecase.dart';
import '../repository/backup_restore_db_repository.dart';

class BackupDBUseCase implements UseCase<void, Future<RequestResult<void>>> {
  BackupDBUseCase(this._backupDB);
  final BackupRestoreDBRepository  _backupDB;


  @override
  Future<RequestResult<void>> call({void params}) async {
    return await _backupDB.backupDB();
  }
  }