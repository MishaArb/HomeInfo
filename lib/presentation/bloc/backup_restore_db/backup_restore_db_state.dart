part of 'backup_restore_db_bloc.dart';

@immutable
sealed class BackupRestoreDbState {}

final class BackupRestoreDbInitial extends BackupRestoreDbState {}

final class RestoreDbSuccessState extends BackupRestoreDbState {
  RestoreDbSuccessState(this.successMessage);

  final String successMessage;
}

final class BackupDbSuccessState extends BackupRestoreDbState {
  BackupDbSuccessState(this.successMessage);

  final String successMessage;
}

final class RestoreDbErrorState extends BackupRestoreDbState {
  RestoreDbErrorState(this.errorMessage);

  final String errorMessage;
}

final class BackupDbErrorState extends BackupRestoreDbState {
  BackupDbErrorState(this.errorMessage);

  final String errorMessage;
}
