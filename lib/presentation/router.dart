import 'package:booking/presentation/presentation.dart';

class Routers {
  static const String main = '/';
  static const String login = '/login';
  static const String register = '/register';
  static const String forgotPassword = '/forgotPassword';
  static const String changePassword = '/changePassword';
  static const String detail = '/detail';
  static const String create = '/create';
  static const String update = '/update';
  static const String profile = '/profile';
  static const String settings = '/settings';
  static const String about = '/about';
  static const String privacy = '/privacy';
  static const String terms = '/terms';

  static const String notFound = '/404';

  final List<String> authRoutes = [
    changePassword,
    profile,
  ];

  final config = GoRouter(
    routes: <RouteBase>[
      GoRoute(
        path: main,
        builder: (BuildContext context, GoRouterState state) {
          return BlocListener<MessageBloc, MessageState?>(
            listenWhen: (previous, current) {
              return current != null;
            },
            listener: (context, message) {
              SnackBarAction? action;
              if (message!.action != null) {
                action = SnackBarAction(
                  label: Translate.of(context).translate(
                    message.action!,
                  ),
                  onPressed: message.onPressed!,
                );
              }
              final snackBar = SnackBar(
                content: Text(
                  Translate.of(context).translate(
                    message.title,
                  ),
                ),
                action: action,
                duration: Duration(
                  seconds: message.duration ?? 1,
                ),
              );
              ScaffoldMessenger.of(context).showSnackBar(
                snackBar,
              );
            },
            child: BlocBuilder<ApplicationBloc, ApplicationState>(
              builder: (context, application) {
                if (application is ApplicationLoaded) {
                  return const MainTab();
                }
                return const SplashScreen();
              },
            ),
          );
        },
        routes: <RouteBase>[
          GoRoute(
            path: login,
            builder: (context, state) {
              final from = state.uri.queryParameters['redirect'];
              return Login(from: from);
            },
          ),
          GoRoute(
            path: register,
            builder: (context, state) {
              return Register();
            },
          ),
          GoRoute(
            path: forgotPassword,
            builder: (context, state) {
              return ForgotPassword();
            },
          ),
          GoRoute(
            path: profile,
            builder: (context, state) {
              return Profile();
            },
          ),
          GoRoute(
            path: settings,
            builder: (BuildContext context, GoRouterState state) {
              return const Setting();
            },
          ),
        ],
        redirect: (context, state) {
          final auth = context.read<AuthenticationBloc>();
          final fail = auth.state is AuthenticationFail;
          if (_instance.authRoutes.contains(state.uri.path) && fail) {
            return '/login?redirect=${state.uri.path}';
          }

          return null;
        },
      ),
    ],
  );

  static final _instance = Routers._internal();

  factory Routers() {
    return _instance;
  }

  Routers._internal();
}
