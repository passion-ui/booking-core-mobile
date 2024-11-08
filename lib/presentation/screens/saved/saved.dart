import 'package:booking/core/core.dart';
import 'package:booking/presentation/presentation.dart';

class Saved extends StatefulWidget {
  const Saved({super.key});

  @override
  State<Saved> createState() => _SavedState();
}

class _SavedState extends State<Saved> {
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
          Translate.of(context).translate('saved'),
        ),
      ),
      body: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, authentication) {
          if (authentication is AuthenticationFail) {
            return _buildAuthentication();
          }
          return Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(12),
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
