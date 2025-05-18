import 'package:booking/domain/domain.dart';

abstract class NewsRepositoryInterface {
  Future<ListingEntity<PostEntity>> get({int? page, String? keyword});
}
