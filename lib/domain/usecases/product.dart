import 'package:booking/domain/domain.dart';

class GetDetailUseCase {
  final ProductRepositoryInterface repository;

  GetDetailUseCase(this.repository);

  Future<ProductEntity> call(ProductEntity item) async {
    return await repository.getDetail(item);
  }
}
