import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../model/reminder_model.dart';

class SQfliteDBServices {
 static const int version = 1;
 static const String _nameDB = 'home_info_db';
 static const String reminderTable = 'reminder';

  Future<Database> _openDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, _nameDB);
    final database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute(
          'CREATE TABLE $reminderTable('
          'id TEXT PRIMARY KEY,'
          'notificationId INTEGER,'
          'date TEXT,'
          'isRepeat INTEGER,'
          'title TEXT,'
          'description TEXT)',
        );
      },
    );
    return database;
  }

  Future<List<ReminderModel>> getAllReminders() async {
    final db = await _openDatabase();
    final List<Map<String, dynamic>> resultMap = await db.query(reminderTable);
    if (resultMap.isNotEmpty) {
      return resultMap.map((e) => ReminderModel.fromJson(e)).toList().reversed.toList();
    }
    return List.empty();
  }

  Future<void> createNewReminder(ReminderModel reminder) async {
    final db = await _openDatabase();
    await db.insert(
      reminderTable,
      reminder.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

 Future<void> deleteReminder(String itemId) async {
   final db = await _openDatabase();
   await db.delete(
     reminderTable,
     where: 'id = ?',
     whereArgs: [itemId],
   );
 }
}
