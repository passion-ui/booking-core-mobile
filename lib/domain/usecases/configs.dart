import 'package:booking/core/core.dart';
import 'package:booking/domain/domain.dart';

class SyncConfigs {
  final ConfigsRepositoryInterface repository;

  SyncConfigs(this.repository);

  Future<void> call() async {
    final configs = await repository.fetchConfigs();
    Logger.log('SyncConfigs: $configs');
  }
}
