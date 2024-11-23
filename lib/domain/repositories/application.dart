import 'package:booking/domain/domain.dart';

abstract class ApplicationRepositoryInterface {
  Future<ApplicationEntity?> get();
  Future<void> save(ApplicationEntity setting);
}
