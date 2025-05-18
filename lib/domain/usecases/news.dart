import 'package:booking/domain/domain.dart';

class GetNewsUseCase {
  final NewsRepositoryInterface repository;

  GetNewsUseCase(this.repository);

  Future<ListingEntity<PostEntity>> call({int? page, String? keyword}) async {
    return await repository.get(page: page, keyword: keyword);
  }
}
