import 'package:booking/core/core.dart';
import 'package:booking/presentation/presentation.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final _emailController = TextEditingController(text: "example@gmail.com");

  final _emailFocusNode = FocusNode();

  String? _errorEmail;

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

  /// Check error
  bool _isError() {
    return _errorEmail != null;
  }

  /// Forgot
  void _onForgot() {
    final email = _emailController.text;

    _validateEmail(email);

    if (!_isError()) {
      final authentication = context.read<ForgotBloc>();
      authentication.add(OnForgotPassword(email: email));
    }
  }

  @override
  Widget build(BuildContext context) {
    final error = _isError();
    return BlocProvider(
      create: (context) => ForgotBloc(),
      child: BlocConsumer<ForgotBloc, ForgotState>(
        listener: (context, state) {
          if (state is ForgotPasswordSuccess) {
            context.pop({
              "email": _emailController.text,
            });
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text(
                Translate.of(context).translate('forgot_password'),
              ),
            ),
            body: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    child: Box(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            Translate.of(context).translate('forgot_message'),
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                          const SizedBox(height: 12),
                          TextField(
                            controller: _emailController,
                            focusNode: _emailFocusNode,
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.email_outlined),
                              labelText: Translate.of(context).translate(
                                'email',
                              ),
                              suffixIcon: IconButton(
                                icon: Icon(Icons.clear),
                                onPressed: () {
                                  _emailController.clear();
                                },
                              ),
                              errorText: _errorEmail,
                            ),
                            onChanged: _validateEmail,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    boxShadow: [
                      BoxShadow(
                        color: Theme.of(context).shadowColor.withAlpha(25),
                        spreadRadius: 1,
                        blurRadius: 12,
                        offset: Offset(0, -4),
                      ),
                    ],
                  ),
                  child: SafeArea(
                    child: Row(
                      children: [
                        Expanded(
                          child: FilledButton(
                            onPressed: error ? null : () => _onForgot(),
                            child: Text(
                              Translate.of(context).translate('register'),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _emailFocusNode.dispose();
    super.dispose();
  }
}
