import 'package:booking/core/core.dart';
import 'package:booking/data/data.dart';
import 'package:booking/domain/domain.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> bindingDependencies() async {
  /**
   * Register core dependencies
   */
  final results = await Future.wait([
    DefaultStorage().init(),
    RelationalStorage().init(),
  ]);

  sl.registerSingleton<DefaultStorage>(results[0] as DefaultStorage);
  sl.registerSingleton<RelationalStorage>(results[1] as RelationalStorage);
  sl.registerSingleton<HTTPClient>(HTTPClient());

  /**
   * Register for repository
   */
  sl.registerSingleton<ApplicationRepositoryInterface>(
    ApplicationRepository(sl(), sl()),
  );

  /**
   * Register for use cases
   */
  sl.registerSingleton<SetupApplication>(SetupApplication(sl()));
  sl.registerSingleton<UpdateApplication>(UpdateApplication(sl()));
}
