import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:home_info/core/request_result/request_result.dart';
import 'package:home_info/domain/usecase/backup_db_usercase.dart';
import 'package:meta/meta.dart';
import '../../../core/constants/app_message.dart';
import '../../../domain/usecase/restore_db_usercase.dart';

part 'backup_restore_db_event.dart';

part 'backup_restore_db_state.dart';

class BackupRestoreDbBloc
    extends Bloc<BackupRestoreDbEvent, BackupRestoreDbState> {
  BackupRestoreDbBloc(this.restoreDbUserCase, this.backupDBUseCase)
      : super(BackupRestoreDbInitial()) {
    on<BackupDbEvent>(_onBackupDB);
    on<RestoreDbEvent>(_onRestoreDB);
  }

  final RestoreDbUserCase restoreDbUserCase;
  final BackupDBUseCase backupDBUseCase;

  _onBackupDB(BackupDbEvent event, Emitter<BackupRestoreDbState> emit) async {
    final requestResult = await backupDBUseCase();
    if (requestResult is RequestSuccess  && event.cxt.mounted) {
      emit(BackupDbSuccessState(AppLocalizations.of(event.cxt)!.db_saved));
    } else if (requestResult is RequestError  && event.cxt.mounted) {
      emit(
        RestoreDbErrorState(
          requestResult.errorMessage! == AppMessage.errorTryLater
              ? AppLocalizations.of(event.cxt)!.error_try_again_later
              : requestResult.errorMessage!,
        ),
      );
    }
  }

  _onRestoreDB(RestoreDbEvent event, Emitter<BackupRestoreDbState> emit) async {
    final requestResult = await restoreDbUserCase();
    if (requestResult is RequestSuccess  && event.cxt.mounted) {
      emit(
        RestoreDbSuccessState(AppLocalizations.of(event.cxt)!.db_has_been_restored),
      );
    } else if (requestResult is RequestError && event.cxt.mounted) {
      emit(
        RestoreDbErrorState(
            requestResult.errorMessage! == AppMessage.fileIsNotDB
                ? AppLocalizations.of(event.cxt)!.selected_file_is_not_database
                : AppLocalizations.of(event.cxt)!.error_try_again_later),
      );
    }
  }
}
