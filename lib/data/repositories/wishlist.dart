import 'package:booking/data/data.dart';
import 'package:booking/domain/domain.dart';

class WishListRepository extends WishListRepositoryInterface {
  final RemoteDataSource _remoteDataSource;

  WishListRepository(this._remoteDataSource);

  @override
  Future<ListingEntity<WishListEntity>> fetchWishList({int? page}) async {
    final list = await _remoteDataSource.fetchWishList(page: page);
    return ListingEntity<WishListEntity>(
      items: list.items.map((e) => e.toEntity()).toList(),
      total: list.total,
      totalPages: list.totalPages,
    );
  }

  @override
  Future<bool> updateWishList(ProductEntity item) async {
    return await _remoteDataSource.updateWishList(
      id: item.id,
      type: item.type,
    );
  }
}
