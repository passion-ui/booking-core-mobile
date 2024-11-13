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
  Future<void> setBool(String key, bool value) async {
    await prefs.setBool(key, value);
  }

  /// set value to shared preferences
  Future<void> setInt(String key, int value) async {
    await prefs.setInt(key, value);
  }

  /// set value to shared preferences
  Future<void> setDouble(String key, double value) async {
    await prefs.setDouble(key, value);
  }

  /// set value to shared preferences
  Future<void> setString(String key, String value) async {
    await prefs.setString(key, value);
  }

  /// remove value from shared preferences
  Future<void> remove(String key) async {
    await prefs.remove(key);
  }
}
