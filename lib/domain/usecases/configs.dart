import 'package:booking/domain/domain.dart';

class SyncConfigUseCase {
  final ConfigsRepositoryInterface repository;

  SyncConfigUseCase(this.repository);

  Future<ConfigEntity> call(Function(ConfigEntity) onSuccess) async {
    final storage = await repository.getConfigs();
    if (storage != null) {
      onSuccess(storage);
    }
    return await repository.fetchConfigs();
  }
}
