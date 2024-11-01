import 'package:booking/core/core.dart';
import 'package:booking/data/data.dart';
import 'package:booking/domain/domain.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> bindingDependencies() async {
  /**
   * Register core dependencies & data layer
   */
  final results = await Future.wait([
    DefaultStorage().init(),
    RelationalStorage().init(),
  ]);

  sl.registerSingleton<LocalDataSource>(
    LocalDataSource(
      results[0] as DefaultStorage,
      results[1] as RelationalStorage,
    ),
  );
  sl.registerSingleton<RemoteDataSource>(RemoteDataSource(HTTPClient()));

  /**
   * Register for repository
   */
  sl.registerSingleton<ApplicationRepositoryInterface>(
    ApplicationRepository(sl(), sl()),
  );
  sl.registerSingleton<ConfigsRepositoryInterface>(
    ConfigsRepository(sl(), sl()),
  );
  /**
   * Register for use cases
   */
  sl.registerSingleton<SetupApplication>(SetupApplication(sl()));
  sl.registerSingleton<UpdateApplication>(UpdateApplication(sl()));
  sl.registerSingleton<SyncConfigs>(SyncConfigs(sl()));
}
