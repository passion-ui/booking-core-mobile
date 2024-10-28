import 'package:booking/domain/domain.dart';

class SetupApplication {
  final ApplicationRepositoryInterface repository;

  SetupApplication(this.repository);

  Future<ApplicationEntity?> call() async {
    return await repository.getApplicationSetting();
  }
}

class UpdateApplication {
  final ApplicationRepositoryInterface repository;

  UpdateApplication(this.repository);

  Future<void> call(ApplicationEntity setting) async {
    return await repository.setApplicationSetting(setting);
  }
}
