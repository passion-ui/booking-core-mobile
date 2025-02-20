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

  @override
  Future<List<RoomEntity>?> getAvailability({
    required ProductEntity item,
    required String startDate,
    required String endDate,
    required int adults,
    required int children,
  }) async {
    final product = await _remoteDataSource.getAvailability(
      type: item.type,
      id: item.id,
      startDate: startDate,
      endDate: endDate,
      adults: adults,
      children: children,
    );
    return product?.map((e) => e.toEntity()).toList();
  }
}
