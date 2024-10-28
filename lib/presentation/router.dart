import 'package:booking/presentation/presentation.dart';

class Routers {
  static const String main = '/';
  static const String login = '/login';
  static const String register = '/register';
  static const String detail = '/detail';
  static const String create = '/create';
  static const String update = '/update';
  static const String profile = '/profile';
  static const String settings = '/settings';
  static const String about = '/about';
  static const String privacy = '/privacy';
  static const String terms = '/terms';

  ///Route authentication for user
  static const String saved = '/saved';

  static const String notFound = '/404';

  static final config = GoRouter(
    routes: <RouteBase>[
      GoRoute(
        path: main,
        builder: (BuildContext context, GoRouterState state) {
          return BlocBuilder<ApplicationBloc, ApplicationState>(
            builder: (context, state) {
              if (state is ApplicationLoaded) {
                return const MainTab();
              }
              return const SplashScreen();
            },
          );
        },
        routes: <RouteBase>[
          GoRoute(
            path: settings,
            builder: (BuildContext context, GoRouterState state) {
              return const Setting();
            },
          ),
          GoRoute(
            path: login,
            builder: (context, state) {
              return Login();
            },
          ),
          GoRoute(
            path: register,
            builder: (context, state) {
              return Login();
            },
          ),

          ///Route authentication for user
          GoRoute(
            path: saved,
            builder: (context, state) {
              return Saved();
            },
          ),
        ],
      ),
    ],
  );
}
