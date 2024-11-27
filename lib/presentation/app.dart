import 'package:booking/core/core.dart';
import 'package:booking/presentation/presentation.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ApplicationBloc>(
          create: (BuildContext context) {
            return ApplicationBloc()..add(OnSetupApplication());
          },
        ),
        BlocProvider<ConfigsBloc>(
          create: (BuildContext context) => ConfigsBloc(),
        ),
        BlocProvider<AuthenticationBloc>(
          create: (BuildContext context) => sl(),
        ),
        BlocProvider<MessageBloc>(
          create: (BuildContext context) => sl(),
        ),
        BlocProvider(
          create: (BuildContext context) => HomeBloc()..add(OnLoadHome()),
        ),
        BlocProvider(
          create: (BuildContext context) => WishListBloc()
            ..add(
              OnLoadWishList(),
            ),
        ),
        BlocProvider(
          create: (BuildContext context) => NewsBloc()
            ..add(
              OnLoadNews(),
            ),
        ),
      ],
      child: BlocConsumer<ApplicationBloc, ApplicationState>(
        listener: (context, state) {
          if (state is ApplicationLoaded) {
            context.read<ConfigsBloc>().add(SyncConfigs());
          }
        },
        builder: (context, state) {
          return BlocBuilder<ApplicationBloc, ApplicationState>(
            builder: (context, application) {
              return MaterialApp.router(
                debugShowCheckedModeBanner: false,
                theme: application.lightTheme,
                darkTheme: application.darkTheme,
                themeMode: application.themeMode,
                locale: application.language,
                localizationsDelegates: Translate.localizationsDelegates,
                supportedLocales: Application.supportedLocales,
                routerConfig: Routers().config,
              );
            },
          );
        },
      ),
    );
  }
}
