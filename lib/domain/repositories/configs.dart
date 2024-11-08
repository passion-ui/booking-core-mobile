import 'package:booking/domain/domain.dart';

abstract class ConfigsRepositoryInterface {
  Future<ConfigEntity?> getConfigs();
  Future<ConfigEntity> fetchConfigs();
}
