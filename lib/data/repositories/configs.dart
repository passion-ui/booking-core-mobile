import 'package:booking/data/data.dart';
import 'package:booking/domain/domain.dart';

class ConfigsRepository extends ConfigsRepositoryInterface {
  final LocalDataSource _localDataSource;
  final RemoteDataSource _remoteDataSource;

  ConfigsRepository(this._localDataSource, this._remoteDataSource);

  @override
  Future<ConfigEntity?> get() async {
    final config = await _localDataSource.getConfigs();
    return config?.toEntity();
  }

  @override
  Future<ConfigEntity> fetch() async {
    final config = await _remoteDataSource.getConfigs();
    return config.toEntity();
  }

  @override
  Future<void> save(ConfigEntity config) async {
    await _localDataSource.saveConfigs(ConfigModel.fromEntity(config));
  }
}
