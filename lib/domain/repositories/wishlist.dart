import 'package:booking/domain/domain.dart';

abstract class WishListRepositoryInterface {
  Future<ListingEntity<WishListEntity>> fetch({int? page});
}
