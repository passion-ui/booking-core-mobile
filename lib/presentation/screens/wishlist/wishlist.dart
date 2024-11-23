import 'package:booking/core/core.dart';
import 'package:booking/presentation/presentation.dart';

class WishList extends StatefulWidget {
  const WishList({super.key});

  @override
  State<WishList> createState() => _WishListState();
}

class _WishListState extends State<WishList> {
  @override
  void initState() {
    super.initState();
    final auth = context.read<AuthenticationBloc>();
    if (auth.state is AuthenticationSuccess) {
      context.read<WishListBloc>().add(OnLoadWishList());
    }
  }

  /// Login
  void _onLogin() {
    context.go(Routers.login);
  }

  /// Build Authentication
  Widget _buildAuthentication() {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Image.asset(
              Images.waiting,
              height: 200,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 24),
            Text(
              Translate.of(context).translate(
                'sign_in_to_continue_saved',
              ),
              style: Theme.of(context).textTheme.labelLarge,
            ),
            const SizedBox(height: 12),
            FilledButton(
              onPressed: _onLogin,
              child: Text(
                Translate.of(context).translate('login'),
              ),
            ),
            const SizedBox(height: 80),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          Translate.of(context).translate('wishlist'),
        ),
      ),
      body: BlocConsumer<AuthenticationBloc, AuthenticationState>(
        listener: (context, state) {
          if (state is AuthenticationSuccess) {
            context.read<WishListBloc>().add(OnLoadWishList());
          }
        },
        builder: (context, authentication) {
          if (authentication is AuthenticationFail) {
            return _buildAuthentication();
          }
          return Center(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [Text("Saved List")],
              ),
            ),
          );
        },
      ),
    );
  }
}
