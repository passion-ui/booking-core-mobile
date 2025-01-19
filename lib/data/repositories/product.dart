import 'package:booking/data/data.dart';
import 'package:booking/domain/domain.dart';

class ProductRepository extends ProductRepositoryInterface {
  final RemoteDataSource _remoteDataSource;

  ProductRepository(this._remoteDataSource);

  @override
  Future<ProductEntity> getDetail(ProductEntity item) async {
    return item;
  }
}
