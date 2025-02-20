import 'package:booking/domain/domain.dart';

class GetDetailUseCase {
  final ProductRepositoryInterface repository;

  GetDetailUseCase(this.repository);

  Future<ProductEntity> call(ProductEntity item) async {
    return await repository.getDetail(item);
  }
}

class GetAvailabilityUseCase {
  final ProductRepositoryInterface repository;

  GetAvailabilityUseCase(this.repository);

  Future<List<RoomEntity>?> call({
    required ProductEntity item,
    required String startDate,
    required String endDate,
    required int adults,
    required int children,
  }) async {
    return await repository.getAvailability(
      item: item,
      startDate: startDate,
      endDate: endDate,
      adults: adults,
      children: children,
    );
  }
}
