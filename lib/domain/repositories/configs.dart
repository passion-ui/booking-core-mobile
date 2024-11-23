import 'package:booking/domain/domain.dart';

abstract class ConfigsRepositoryInterface {
  Future<ConfigEntity?> get();
  Future<void> save(ConfigEntity config);
  Future<ConfigEntity> fetch();
}
