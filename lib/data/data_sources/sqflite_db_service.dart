import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../model/reminder_model.dart';
import '../model/home_service_model.dart';

class SQfliteDBServices {
  static const int version = 1;
  static const String _nameDB = 'home_info_db';
  static const String reminderTable = 'reminder';
  static const String homeServiceTable = 'home_service';

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
        await db.execute(
          'CREATE TABLE $homeServiceTable('
          'id TEXT PRIMARY KEY,'
          'title TEXT,'
          'icon INTEGER,'
          'iconColor INTEGER)',
        );
      },
    );
    return database;
  }

  /// REMINDERS
  Future<List<ReminderModel>> getAllReminders() async {
    final db = await _openDatabase();
    final List<Map<String, dynamic>> resultMap = await db.query(reminderTable);
    if (resultMap.isNotEmpty) {
      return resultMap
          .map((e) => ReminderModel.fromJson(e))
          .toList()
          .reversed
          .toList();
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

  ///HOME SERVICES
  Future<List<HomeServiceModel>> getAllHomeServices() async {
    final db = await _openDatabase();
    final List<Map<String, dynamic>> resultMap =
        await db.query(homeServiceTable);
    if (resultMap.isNotEmpty) {
      return resultMap
          .map((e) => HomeServiceModel.fomMap(e))
          .toList()
          .reversed
          .toList();
    }
    return List.empty();
  }

  Future<void> createNewHomeService(HomeServiceModel service) async {
    final db = await _openDatabase();
    await db.insert(
      homeServiceTable,
      service.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> deleteHomeService(String itemId) async {
    final db = await _openDatabase();
    await db.delete(
      homeServiceTable,
      where: 'id = ?',
      whereArgs: [itemId],
    );
  }
}
