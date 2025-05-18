import 'package:booking/data/data.dart';
import 'package:booking/domain/domain.dart';

class HomeRepository extends HomeRepositoryInterface {
  final RemoteDataSource _remoteDataSource;

  HomeRepository(this._remoteDataSource);

  @override
  Future<List<BlockHomeEntity>> get() async {
    final home = await _remoteDataSource.loadHome();
    return home.map((e) => e.toEntity()).toList();
  }
}
