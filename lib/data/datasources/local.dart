import 'dart:convert';

import 'package:booking/core/core.dart';
import 'package:booking/data/data.dart';

class LocalDataSource {
  final DefaultStorage _defaultStorage;
  final RelationalStorage _relationalStorage;
  final String _key = "APP_SETTINGS";

  LocalDataSource(this._defaultStorage, this._relationalStorage);

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

  Future<UserModel?> getUser() {
    throw UnimplementedError();
  }
}
