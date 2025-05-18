import 'package:booking/domain/domain.dart';

class LoadHomeUseCase {
  final HomeRepositoryInterface repository;

  LoadHomeUseCase(this.repository);

  Future<List<BlockHomeEntity>> call() async {
    return await repository.get();
  }
}
