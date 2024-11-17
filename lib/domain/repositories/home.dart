import 'package:booking/domain/domain.dart';

abstract class HomeRepositoryInterface {
  Future<List<BlockHomeEntity>> fetch();
}
