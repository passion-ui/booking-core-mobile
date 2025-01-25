import 'package:booking/domain/domain.dart';

abstract class WishListRepositoryInterface {
  Future<ListingEntity<WishListEntity>> fetchWishList({int? page});
  Future<bool> updateWishList(ProductEntity item);
}
