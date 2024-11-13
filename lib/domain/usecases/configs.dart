import 'package:booking/domain/domain.dart';

class SyncConfigUseCase {
  final ConfigsRepositoryInterface repository;

  SyncConfigUseCase(this.repository);

  Future<ConfigEntity> call(Function(ConfigEntity) onSuccess) async {
    ConfigEntity? storage = await repository.getConfigs();
    if (storage != null) {
      onSuccess(storage);
    }

    storage = await repository.fetchConfigs();
    await repository.saveConfigs(storage);

    return storage;
  }
}
