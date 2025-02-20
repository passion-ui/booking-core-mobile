import 'package:booking/domain/domain.dart';

abstract class ProductRepositoryInterface {
  Future<ProductEntity> getDetail(ProductEntity item);
  Future<List<RoomEntity>?> getAvailability({
    required ProductEntity item,
    required String startDate,
    required String endDate,
    required int adults,
    required int children,
  });
}
