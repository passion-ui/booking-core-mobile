import 'package:booking/core/core.dart';
import 'package:booking/injector.dart';
import 'package:booking/presentation/presentation.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ApplicationBloc>(
          create: (BuildContext context) => ApplicationBloc(
            sl(),
            sl(),
          )..add(OnSetupApplication()),
        ),
      ],
      child: BlocBuilder<ApplicationBloc, ApplicationState>(
        builder: (context, application) {
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            theme: application.lightTheme,
            darkTheme: application.darkTheme,
            themeMode: application.themeMode,
            locale: application.language,
            localizationsDelegates: Translate.localizationsDelegates,
            supportedLocales: Application.supportedLocales,
            routerConfig: Routers.config,
          );
        },
      ),
    );
  }
}
