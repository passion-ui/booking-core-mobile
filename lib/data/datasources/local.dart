import 'dart:convert';

import 'package:booking/core/core.dart';
import 'package:booking/data/data.dart';

class LocalDataSource {
  final DefaultStorage _defaultStorage;
  final RelationalStorage _relationalStorage;
  final SecureStorage _secureStorage;

  final String _key = "APP_SETTINGS";

  LocalDataSource(
    this._defaultStorage,
    this._relationalStorage,
    this._secureStorage,
  );

  Future<ApplicationModel?> getApplicationSettings() async {
    final jsonString = _defaultStorage.getString(_key);
    if (jsonString != null) {
      final json = jsonDecode(jsonString);
      return ApplicationModel.fromJson(json);
    }
    return null;
  }

  Future<bool> setApplicationSettings(ApplicationModel setting) async {
    return await _defaultStorage.setString(
      _key,
      jsonEncode(setting.toJson()),
    );
  }

  Future<void> saveUserData(UserModel user) async {
    return await _secureStorage.write("user", jsonEncode(user.toJson()));
  }

  Future<UserModel?> getUserData() async {
    final jsonString = await _secureStorage.read("user");
    if (jsonString != null) {
      final json = jsonDecode(jsonString);
      return UserModel.fromJson(json);
    }
    return null;
  }

  Future<void> deleteUserData() async {
    return await _secureStorage.delete("user");
  }
}
