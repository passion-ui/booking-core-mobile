import 'package:booking/data/data.dart';
import 'package:booking/domain/domain.dart';

class ApplicationRepository implements ApplicationRepositoryInterface {
  final LocalDataSource _localDataSource;
  final RemoteDataSource _remoteDataSource;

  ApplicationRepository(this._remoteDataSource, this._localDataSource);

  @override
  Future<ApplicationEntity?> get() async {
    final application = await _localDataSource.getApplicationSettings();
    if (application != null) {
      return application.toEntity();
    }
    return null;
  }

  @override
  Future<void> save(ApplicationEntity setting) async {
    _remoteDataSource.setBaseUrl(setting.domain);
    await _localDataSource.setApplicationSettings(
      ApplicationModel.fromEntity(setting),
    );
  }
}
