import 'dart:convert';

import 'package:booking/core/core.dart';
import 'package:booking/data/data.dart';
import 'package:booking/domain/domain.dart';

class ApplicationRepository implements ApplicationRepositoryInterface {
  final DefaultStorage _defaultStorage;
  final String _key = "APP_SETTINGS";

  ApplicationRepository(this._defaultStorage);

  @override
  Future<ApplicationEntity?> getApplicationSetting() async {
    final jsonString = _defaultStorage.getString(_key);
    if (jsonString != null) {
      final json = jsonDecode(jsonString);
      return ApplicationModel.fromJson(json).toEntity();
    }
    return null;
  }

  @override
  Future<bool> setApplicationSetting(ApplicationEntity setting) async {
    final application = ApplicationModel.fromEntity(setting);
    return await _defaultStorage.setString(
      _key,
      jsonEncode(application.toJson()),
    );
  }
}
