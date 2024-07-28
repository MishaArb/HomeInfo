
part of 'backup_restore_db_bloc.dart';


class BackupRestoreDbEvent {}

class BackupDbEvent extends BackupRestoreDbEvent {
  BackupDbEvent(this.cxt);
  BuildContext cxt;
}

class RestoreDbEvent extends BackupRestoreDbEvent {
  RestoreDbEvent(this.cxt);
  BuildContext cxt;
}
