import 'package:booking/core/core.dart';
import 'package:booking/data/data.dart';
import 'package:booking/domain/domain.dart';
import 'package:booking/presentation/presentation.dart';

Future<void> bindingDependencies() async {
  /**
   * Register core dependencies & data layer
   */
  final results = await Future.wait([
    DefaultStorage.init(),
    RelationalStorage.init(),
    SecureStorage.init(),
    DeviceInfo.init(),
  ]);

  sl.registerSingleton<LocalDataSource>(
    LocalDataSource(
      results[0] as DefaultStorage,
      results[1] as RelationalStorage,
      results[2] as SecureStorage,
    ),
  );
  sl.registerSingleton<DeviceInfo>(results[3] as DeviceInfo);
  sl.registerSingleton<RemoteDataSource>(
    RemoteDataSource(HTTPClient(), sl()),
  );

  /**
   * Register for repository
   */
  sl.registerSingleton<ApplicationRepositoryInterface>(
    ApplicationRepository(sl(), sl()),
  );
  sl.registerSingleton<ConfigsRepositoryInterface>(
    ConfigsRepository(sl(), sl()),
  );
  sl.registerSingleton<AuthenticationRepositoryInterface>(
    AuthenticationRepository(
      sl(),
      sl(),
    ),
  );

  /**
   * Register for bloc
   */
  sl.registerSingleton<MessageBloc>(MessageBloc());
  sl.registerSingleton<AuthenticationBloc>(
    AuthenticationBloc(),
  );
}
