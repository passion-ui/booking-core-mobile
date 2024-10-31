import 'package:booking/domain/domain.dart';

abstract class ConfigsRepositoryInterface {
  Future<void> getConfigs();
  Future<ConfigsEntity?> fetchConfigs();
}
