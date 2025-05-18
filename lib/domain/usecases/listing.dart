import 'package:booking/domain/domain.dart';

class GetListingUseCase {
  final ListingRepositoryInterface repository;

  GetListingUseCase(this.repository);

  Future<ListingEntity<ProductEntity>> call({
    required BookingEntity item,
    int? page,
  }) async {
    return await repository.get(item: item, page: page);
  }
}
