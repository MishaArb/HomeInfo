import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter_file_dialog/flutter_file_dialog.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../../core/constants/db_const.dart';
import '../../core/constants/app_message.dart';
import '../../core/request_result/request_result.dart';
import '../../domain/repository/backup_restore_db_repository.dart';

class BackupRestoreDBRepositoryImpl implements BackupRestoreDBRepository {
  // Future<void> shareDB() async {
  //   final dbPath = await getDatabasesPath();
  //   if (dbPath != null) {
  //     final result = await Share.shareXFiles([
  //       XFile(dbPath),
  //     ]);
  // if (result.status == ShareResultStatus.success) {
  //   print('Thank you for sharing the picture!');
  // }
  //   }
  // }

  @override
  Future<RequestResult<String>> backupDB() async {
    final databasesPath = await getDatabasesPath();
    final dbPath = join(databasesPath, DbConst.nameDB);

    final params = SaveFileDialogParams(
        sourceFilePath: dbPath,
        fileName:
            'HomeInfo ${DateFormat('dd.MM.yyyy-kk:mm').format(DateTime.now())}.db');

    final result = await FlutterFileDialog.saveFile(params: params);
    if (result != null) {
      return RequestSuccess(AppMessage.savedDB);
    } else {
      return RequestError(AppMessage.errorTryLater) ;
    }
  }

  @override
  Future<RequestResult<String>> restoreDB() async {
    final databasesPath = await getDatabasesPath();
    final dbPath = join(databasesPath, 'home_info_db');

    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      try {
        File file = File(result.files.single.path!);
        final isValid = await isValidDB(result);
        if (!isValid) {
          return RequestError(AppMessage.fileIsNotDB);
        }
        await deleteDatabase(dbPath);
        await File(file.path).copy(dbPath);
        return RequestSuccess(AppMessage.restoredDB);
      } catch (e) {
        return RequestError(e.toString());
      }
    } else {
      return RequestError(AppMessage.errorTryLater);
    }
  }

  Future<bool> isValidDB(FilePickerResult result) async {
    return result.files.single.path!.endsWith('.db');
  }
}
