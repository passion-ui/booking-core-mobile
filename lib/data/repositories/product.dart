import 'package:booking/data/data.dart';
import 'package:booking/domain/domain.dart';

class ProductRepository extends ProductRepositoryInterface {
  final RemoteDataSource _remoteDataSource;

  ProductRepository(this._remoteDataSource);

  @override
  Future<ProductEntity> getDetail(ProductEntity item) async {
    final product = await _remoteDataSource.getProductDetail(
      type: item.type,
      id: item.id,
    );
    return product.toEntity();
  }
}
