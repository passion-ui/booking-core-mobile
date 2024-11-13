import 'package:booking/domain/domain.dart';

abstract class ConfigsRepositoryInterface {
  Future<ConfigEntity?> getConfigs();
  Future<void> saveConfigs(ConfigEntity config);
  Future<ConfigEntity> fetchConfigs();
}
