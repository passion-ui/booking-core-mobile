import 'package:booking/core/core.dart';
import 'package:booking/data/data.dart';
import 'package:booking/domain/domain.dart';

class ApplicationRepository implements ApplicationRepositoryInterface {
  final LocalDataSource _localDataSource;
  final HTTPClient _httpClient;

  ApplicationRepository(this._httpClient, this._localDataSource);

  @override
  Future<ApplicationEntity?> getApplicationSetting() async {
    final application = await _localDataSource.getApplicationSettings();
    if (application != null) {
      return application.toEntity();
    }
    return null;
  }

  @override
  Future<bool> setApplicationSetting(ApplicationEntity setting) async {
    _httpClient.baseUrl = setting.domain;

    return await _localDataSource.setApplicationSettings(
      ApplicationModel.fromEntity(setting),
    );
  }
}
