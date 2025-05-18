import 'package:booking/data/data.dart';
import 'package:booking/domain/domain.dart';

class ListingRepository extends ListingRepositoryInterface {
  final RemoteDataSource _remoteDataSource;

  ListingRepository(this._remoteDataSource);

  @override
  Future<ListingEntity<ProductEntity>> get({
    required BookingEntity item,
    int? page,
  }) async {
    final list = await _remoteDataSource.getListing(
      type: item.id,
      page: page,
    );
    return ListingEntity<ProductEntity>(
      items: list.items.map((e) => e.toEntity()).toList(),
      total: list.total,
      totalPages: list.totalPages,
    );
  }
}
