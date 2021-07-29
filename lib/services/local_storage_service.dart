import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_dot_do/constants.dart';

class LocalStorageService {
  static late LocalStorageService _instance;
  static late SharedPreferences _preferences;

  static const String authStateKey = 'is_LoggedIn';
  static const String firstLoginKey = 'is_first_login';

  static Future<LocalStorageService> getInstance() async {
    _instance = LocalStorageService();
    _preferences = await SharedPreferences.getInstance();
    return _instance;
  }

  dynamic _getFromDisk(String key) {
    var value = _preferences.get(key);
    return value;
  }

  void _saveToDisk<T>(String key, T value) {
    if (value is bool) {
      _preferences.setBool(key, value);
    } else if (value is double) {
      _preferences.setDouble(key, value);
    } else if (value is int) {
      _preferences.setInt(key, value);
    } else if (value is String) {
      _preferences.setString(key, value);
    } else if (value is List<String>) {
      _preferences.setStringList(key, value);
    } else {
      debugPrint('passed value is none of the specified type');
    }
  }

  bool get isLoggedIn => _getFromDisk(authStateKey) ?? false;
  set isLoggedIn(bool isLoggedIn) => _saveToDisk(authStateKey, isLoggedIn);

  bool get isFirstLogin => _getFromDisk(firstLoginKey) ?? false;
  set isFirstLogin(bool isFirstLogin) =>
      _saveToDisk(firstLoginKey, isFirstLogin);

  String get displayName => _getFromDisk('displayName') ?? '';
  set displayName(String name) => _saveToDisk('displayName', name);
  String get taskMap => _getFromDisk(taskMapKey);
  set taskMap(String taskMapjson) => _saveToDisk(taskMapKey, taskMapjson);
}
