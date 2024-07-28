import 'package:home_info/core/request_result/request_result.dart';

abstract interface class BackupRestoreDBRepository{
  Future<RequestResult<void>> backupDB();
  Future<RequestResult<void>> restoreDB();
}