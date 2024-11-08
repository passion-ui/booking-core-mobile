import 'package:shared_preferences/shared_preferences.dart';

class DefaultStorage {
  final SharedPreferences prefs;
  final String prefSettings = "APP_SETTINGS";
  final String prefConfigs = "APP_CONFIGS";

  DefaultStorage(this.prefs);

  static Future<DefaultStorage> init() async {
    final prefs = await SharedPreferences.getInstance();
    return DefaultStorage(prefs);
  }

  /// get value from shared preferences
  Object? get(String key) {
    return prefs.get(key);
  }

  bool? getBool(String key) {
    return prefs.getBool(key);
  }

  int? getInt(String key) {
    return prefs.getInt(key);
  }

  double? getDouble(String key) {
    return prefs.getDouble(key);
  }

  String? getString(String key) {
    return prefs.getString(key);
  }

  /// set value to shared preferences
  Future<bool> setBool(String key, bool value) async {
    return await prefs.setBool(key, value);
  }

  Future<bool> setInt(String key, int value) async {
    return await prefs.setInt(key, value);
  }

  Future<bool> setDouble(String key, double value) async {
    return await prefs.setDouble(key, value);
  }

  Future<bool> setString(String key, String value) async {
    return await prefs.setString(key, value);
  }

  /// remove value from shared preferences
  Future<bool> remove(String key) async {
    return await prefs.remove(key);
  }
}
