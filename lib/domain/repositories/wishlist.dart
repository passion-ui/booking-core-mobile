import 'package:booking/domain/domain.dart';

abstract class WishListRepositoryInterface {
  Future<ListingEntity<WishListEntity>> get({int? page});
  Future<bool> update(ProductEntity item);
}
