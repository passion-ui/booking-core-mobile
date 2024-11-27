import 'package:booking/domain/domain.dart';

abstract class NewsRepositoryInterface {
  Future<ListingEntity<PostEntity>> fetch({int? page, String? keyword});
}
