import 'package:booking/data/data.dart';
import 'package:booking/domain/domain.dart';

class NewsRepository extends NewsRepositoryInterface {
  final RemoteDataSource _remoteDataSource;

  NewsRepository(this._remoteDataSource);

  @override
  Future<ListingEntity<PostEntity>> fetch({int? page, String? keyword}) async {
    final list = await _remoteDataSource.fetchNews(
      page: page,
      keyword: keyword,
    );
    return ListingEntity<PostEntity>(
      items: list.items.map((e) => e.toEntity()).toList(),
      total: list.total,
      totalPages: list.totalPages,
    );
  }
}
