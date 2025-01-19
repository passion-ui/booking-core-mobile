import 'package:booking/domain/domain.dart';

abstract class ProductRepositoryInterface {
  Future<ProductEntity> getDetail(ProductEntity item);
}
