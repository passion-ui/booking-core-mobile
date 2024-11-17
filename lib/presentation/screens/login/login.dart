import 'package:booking/core/core.dart';
import 'package:booking/presentation/presentation.dart';

class Login extends StatefulWidget {
  final String? from;

  const Login({super.key, this.from});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _emailController = TextEditingController(
    text: "pau.passionui@gmail.com",
  );
  final _passwordController = TextEditingController(
    text: "admin123",
  );

  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();

  bool _secure = true;
  String? _errorEmail;
  String? _errorPassword;

  @override
  void initState() {
    super.initState();
    _emailFocusNode.requestFocus();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  /// Validate email
  void _validateEmail(String email) {
    final email = _emailController.text;
    setState(() {
      _errorEmail = Validator.validate(
        Rule(
          require: true,
          email: true,
        ),
        email,
      );
    });
  }

  /// Validate password
  void _validatePassword(String password) {
    final password = _passwordController.text;
    setState(() {
      _errorPassword = Validator.validate(
        Rule(
          require: true,
          minLength: 6,
        ),
        password,
      );
    });
  }

  /// Login
  void _onLogin() {
    _validateEmail(_emailController.text);
    _validatePassword(_passwordController.text);
    if (_errorEmail == null && _errorPassword == null) {
      final email = _emailController.text;
      final password = _passwordController.text;
      final authentication = context.read<AuthenticationBloc>();
      authentication.add(
        OnLogIn(
          username: email,
          password: password,
        ),
      );
    }
  }

  ///On forgot password
  void _onForgotPassword() {
    context.go(Routers.forgotPassword);
  }

  ///On register
  void _onRegister() async {
    final Map<String, dynamic>? info = await context.push(Routers.register);

    if (info != null) {
      final email = info['email'];
      final password = info['password'];
      _emailController.text = email;
      _passwordController.text = password;
      _onLogin();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        if (state is AuthenticationSuccess) {
          final from = widget.from;
          if (from != null) {
            context.go(from);
          } else {
            context.go(Routers.main);
          }
        }
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            Translate.of(context).translate('login'),
          ),
        ),
        body: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                TextField(
                  controller: _emailController,
                  focusNode: _emailFocusNode,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.email_outlined),
                    labelText: Translate.of(context).translate('email'),
                    suffixIcon: IconButton(
                      icon: Icon(Icons.clear),
                      onPressed: () {
                        _emailController.clear();
                      },
                    ),
                    errorText: _errorEmail,
                  ),
                  onSubmitted: (value) {
                    _passwordFocusNode.requestFocus();
                  },
                  onChanged: _validateEmail,
                ),
                const SizedBox(height: 12),
                TextField(
                  obscureText: _secure,
                  controller: _passwordController,
                  focusNode: _passwordFocusNode,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.lock_outline),
                    labelText: Translate.of(context).translate(
                      'password',
                    ),
                    errorText: _errorPassword,
                    suffixIcon: IconButton(
                      icon: Icon(_secure
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined),
                      onPressed: () {
                        setState(() {
                          _secure = !_secure;
                        });
                      },
                    ),
                  ),
                  onChanged: _validatePassword,
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: FilledButton(
                        onPressed: _onLogin,
                        child: Text(
                          Translate.of(context).translate('login'),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: _onRegister,
                      child: Text(
                        Translate.of(context).translate('register'),
                      ),
                    ),
                    TextButton(
                      onPressed: _onForgotPassword,
                      child: Text(
                        Translate.of(context).translate(
                          'forgot_password',
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
