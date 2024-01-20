import 'package:shared_preferences/shared_preferences.dart';

class SharedStorageService {
  Future<void> saveStorageData(String key, dynamic data) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (data is int) {
      await prefs.setInt(key, data);
    } else if (data is String) {
      await prefs.setString(key, data);
    } else if (data is bool) {
      await prefs.setBool(key, data);
    }
  }

  Future<dynamic> loadStorageData(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.get(key);
  }
}
