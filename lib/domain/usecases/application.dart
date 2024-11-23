import 'package:booking/domain/domain.dart';

class SetupApplicationUseCase {
  final ApplicationRepositoryInterface repository;

  SetupApplicationUseCase(this.repository);

  Future<ApplicationEntity?> call() async {
    return await repository.get();
  }
}

class UpdateApplicationUseCase {
  final ApplicationRepositoryInterface repository;

  UpdateApplicationUseCase(this.repository);

  Future<void> call(ApplicationEntity setting) async {
    return await repository.save(setting);
  }
}
