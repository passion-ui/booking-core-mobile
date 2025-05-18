import 'package:booking/domain/domain.dart';

abstract class ListingRepositoryInterface {
  Future<ListingEntity<ProductEntity>> get({
    required BookingEntity item,
    int? page,
  });
}
