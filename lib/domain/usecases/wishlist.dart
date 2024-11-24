import 'package:booking/domain/domain.dart';

class GetWishListUseCase {
  final WishListRepositoryInterface repository;

  GetWishListUseCase(this.repository);

  Future<ListingEntity<WishListEntity>> call(int page) async {
    return await repository.fetch(page);
  }
}
