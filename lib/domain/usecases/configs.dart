import 'package:booking/core/core.dart';
import 'package:booking/domain/domain.dart';

class SyncConfigUseCase {
  final ConfigsRepositoryInterface repository;

  SyncConfigUseCase(this.repository);

  Future<void> call() async {
    final configs = await repository.fetchConfigs();
    Logger.log('SyncConfigs: $configs');
  }
}
