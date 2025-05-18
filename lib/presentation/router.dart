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
  static const String newDetail = '/newDetail';
  static const String cart = '/cart';
  static const String checkout = '/checkout';
  static const String productDetail = '/productDetail';
  static const String maps = '/maps';
  static const String gallery = '/gallery';
  static const String review = '/review';
  static const String notFound = '/404';

  final List<String> _authRoutes = [review, checkout];

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
                  final color = Theme.of(context).cardColor;
                  final brightness = Theme.of(context).brightness;
                  Future.delayed(
                    const Duration(milliseconds: 50),
                    () {
                      SystemChrome.setSystemUIOverlayStyle(
                        SystemUiOverlayStyle(
                          systemNavigationBarColor: color,
                          systemNavigationBarIconBrightness: brightness,
                          statusBarColor: Colors.transparent,
                          statusBarIconBrightness: brightness,
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
            pageBuilder: (BuildContext context, GoRouterState state) {
              final from = state.uri.queryParameters['redirect'];
              return MaterialPage(
                child: Login(from: from),
                fullscreenDialog: true,
              );
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
              return Listing(item: state.extra as BookingEntity);
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
              return ProductDetail(item: state.extra as ProductEntity);
            },
          ),
          GoRoute(
            path: newDetail,
            builder: (BuildContext context, GoRouterState state) {
              return const DetailNew();
            },
          ),
          GoRoute(
            path: cart,
            builder: (BuildContext context, GoRouterState state) {
              return Cart(
                productDetailCubit: state.extra as ProductDetailCubit,
              );
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
              if (state.extra is List<String>) {
                return Gallery(
                  title: '',
                  images: state.extra as List<String>,
                );
              } else if (state.extra is ProductEntity) {
                final item = state.extra as ProductEntity;
                return Gallery(
                  title: item.title,
                  images: item.gallery,
                );
              } else if (state.extra is RoomEntity) {
                final item = state.extra as RoomEntity;
                return Gallery(
                  title: item.title,
                  images: item.gallery,
                );
              }
              return const Gallery(title: '', images: []);
            },
          ),
          GoRoute(
            path: checkout,
            builder: (BuildContext context, GoRouterState state) {
              return CheckOut();
            },
          ),
          GoRoute(
            path: review,
            builder: (BuildContext context, GoRouterState state) {
              return Review();
            },
          ),
        ],
        redirect: (context, state) {
          final auth = context.read<AuthenticationBloc>();
          final fail = auth.state is AuthenticationFail;
          if (_instance._authRoutes.contains(state.uri.path) && fail) {
            return '/login?redirect=${state.uri.path}';
          }

          return null;
        },
      ),
    ],
  );

  Future<void> ensureAuthentication(
    BuildContext context, {
    required Function action,
  }) async {
    final auth = context.read<AuthenticationBloc>();
    final success = auth.state is AuthenticationSuccess;
    if (success) {
      action();
    } else {
      final result = await context.push(Routers.login);
      if (result != null) {
        action();
      }
    }
  }

  static final _instance = Routers._internal();

  factory Routers() {
    return _instance;
  }

  Routers._internal();
}
