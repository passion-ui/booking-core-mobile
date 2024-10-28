import 'package:booking/domain/domain.dart';

abstract class ApplicationRepositoryInterface {
  Future<ApplicationEntity?> getApplicationSetting();
  Future<void> setApplicationSetting(ApplicationEntity setting);
}
