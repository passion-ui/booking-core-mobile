import 'package:booking/data/data.dart';
import 'package:booking/domain/domain.dart';

class ConfigsRepository extends ConfigsRepositoryInterface {
  final LocalDataSource _localDataSource;
  final RemoteDataSource _remoteDataSource;

  ConfigsRepository(this._localDataSource, this._remoteDataSource);

  Future<void> getConfigs() async {}

  @override
  Future<ConfigsEntity?> fetchConfigs() async {}
}
