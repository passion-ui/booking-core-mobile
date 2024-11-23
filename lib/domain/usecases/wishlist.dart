import 'package:booking/domain/domain.dart';

class GetWishListUseCase {
  final WishListRepositoryInterface repository;

  GetWishListUseCase(this.repository);

  Future<void> call() async {
    return await repository.fetch();
  }
}
