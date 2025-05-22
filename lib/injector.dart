import 'package:booking/core/core.dart';
import 'package:booking/data/data.dart';
import 'package:booking/domain/domain.dart';
import 'package:booking/presentation/presentation.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> bindingDependencies() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = AppBlocObserver();
  /**
   * Register core dependencies & data layer
   */
  WidgetsFlutterBinding.ensureInitialized();
  final results = await Future.wait([
    DefaultStorage.init(),
    DeviceInfo.init(),
    Firebase.initializeApp(options: FirebaseCore.currentPlatform),
  ]);

  sl.registerSingleton<LocalDataSource>(
    LocalDataSource(
      results[0] as DefaultStorage,
      SecureStorage.init(),
    ),
  );
  sl.registerSingleton<DeviceInfo>(results[1] as DeviceInfo);
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
    AuthenticationRepository(sl(), sl()),
  );
  sl.registerSingleton<HomeRepositoryInterface>(
    HomeRepository(sl()),
  );
  sl.registerSingleton<WishListRepositoryInterface>(
    WishListRepository(sl()),
  );
  sl.registerSingleton<NewsRepositoryInterface>(
    NewsRepository(sl()),
  );
  sl.registerSingleton<ProductRepositoryInterface>(
    ProductRepository(sl()),
  );
  sl.registerSingleton<ListingRepositoryInterface>(
    ListingRepository(sl()),
  );

  /**
   * Register for bloc
   */
  sl.registerSingleton<MessageBloc>(MessageBloc());
  sl.registerSingleton<AuthenticationBloc>(AuthenticationBloc());
}
