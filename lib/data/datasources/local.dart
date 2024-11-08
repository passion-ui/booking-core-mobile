import 'dart:convert';

import 'package:booking/core/core.dart';
import 'package:booking/data/data.dart';

class LocalDataSource {
  final DefaultStorage _defaultStorage;
  final RelationalStorage _relationalStorage;
  final SecureStorage _secureStorage;

  LocalDataSource(
    this._defaultStorage,
    this._relationalStorage,
    this._secureStorage,
  );

  /// Get Application Settings
  Future<ApplicationModel?> getApplicationSettings() async {
    final jsonString = _defaultStorage.getString(
      _defaultStorage.prefSettings,
    );
    if (jsonString != null) {
      final json = jsonDecode(jsonString);
      return ApplicationModel.fromJson(json);
    }
    return null;
  }

  /// Set Application Settings
  Future<bool> setApplicationSettings(ApplicationModel setting) async {
    return await _defaultStorage.setString(
      _defaultStorage.prefSettings,
      jsonEncode(setting.toJson()),
    );
  }

  /// Get Application Settings
  Future<ConfigModel?> getConfigs() async {
    final jsonString = _defaultStorage.getString(
      _defaultStorage.prefConfigs,
    );
    if (jsonString != null) {
      final json = jsonDecode(jsonString);
      return ConfigModel.fromJson(json);
    }
    return null;
  }

  /// Save User Data
  Future<void> saveUserData(UserModel user) async {
    return await _secureStorage.write("user", jsonEncode(user.toJson()));
  }

  /// Get User Data
  Future<UserModel?> getUserData() async {
    final jsonString = await _secureStorage.read("user");
    if (jsonString != null) {
      final json = jsonDecode(jsonString);
      return UserModel.fromJson(json);
    }
    return null;
  }

  /// Delete User Data
  Future<void> deleteUserData() async {
    return await _secureStorage.delete("user");
  }
}
