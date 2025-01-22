import 'package:booking/domain/domain.dart';
import 'package:booking/presentation/presentation.dart';
import 'package:flutter/services.dart';

class Routers {
  static const String main = '/';
  static const String login = '/login';
  static const String register = '/register';
  static const String forgotPassword = '/forgotPassword';
  static const String changePassword = '/changePassword';
  static const String profile = '/profile';
  static const String author = '/author';
  static const String settings = '/settings';
  static const String about = '/about';
  static const String privacy = '/privacy';
  static const String terms = '/terms';
  static const String listing = '/listing';
  static const String search = '/search';
  static const String scanQR = '/scanQR';
  static const String detailNew = '/detailNew';
  static const String productDetail = '/productDetail';
  static const String maps = '/maps';
  static const String gallery = '/gallery';

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
                  final color = Theme.of(context).colorScheme.surfaceContainer;
                  final brightness = Theme.of(context).brightness;
                  Future.delayed(
                    const Duration(milliseconds: 50),
                    () {
                      SystemChrome.setSystemUIOverlayStyle(
                        SystemUiOverlayStyle(
                          systemNavigationBarColor: color,
                          systemNavigationBarIconBrightness: brightness,
                        ),
                      );
                    },
                  );
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
          GoRoute(
            path: author,
            builder: (BuildContext context, GoRouterState state) {
              return const Author();
            },
          ),
          GoRoute(
            path: listing,
            builder: (BuildContext context, GoRouterState state) {
              return const Listing();
            },
          ),
          GoRoute(
            path: search,
            builder: (BuildContext context, GoRouterState state) {
              return const Search();
            },
          ),
          GoRoute(
            path: scanQR,
            builder: (BuildContext context, GoRouterState state) {
              return const ScanQR();
            },
          ),
          GoRoute(
            path: productDetail,
            builder: (BuildContext context, GoRouterState state) {
              if (state.extra is HotelEntity) {
                return HotelDetail(item: state.extra as HotelEntity);
              }
              return ProductDetail(item: state.extra as ProductEntity);
            },
          ),
          GoRoute(
            path: detailNew,
            builder: (BuildContext context, GoRouterState state) {
              return const DetailNew();
            },
          ),
          GoRoute(
            path: maps,
            builder: (BuildContext context, GoRouterState state) {
              return Maps(item: state.extra as GPSEntity);
            },
          ),
          GoRoute(
            path: gallery,
            builder: (BuildContext context, GoRouterState state) {
              return Gallery(product: state.extra as ProductEntity);
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
