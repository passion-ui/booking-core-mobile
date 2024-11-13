import 'package:booking/core/core.dart';
import 'package:booking/presentation/presentation.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _firstNameController = TextEditingController(text: "John");
  final _lastNameController = TextEditingController(text: "Doe");
  final _emailController = TextEditingController(text: "example@gmail.com");
  final _passwordController = TextEditingController(text: "123456");

  final _firstNameFocusNode = FocusNode();
  final _lastNameFocusNode = FocusNode();
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();

  bool _secure = true;
  bool _agree = false;

  String? _errorFirstName;
  String? _errorLastName;
  String? _errorEmail;
  String? _errorPassword;

  /// Validate first name
  void _validateFirstName(String firstName) {
    final firstName = _firstNameController.text;
    setState(() {
      _errorFirstName = Validator.validate(
        Rule(
          require: true,
        ),
        firstName,
      );
    });
  }

  /// Validate last name
  void _validateLastName(String lastName) {
    final lastName = _lastNameController.text;
    setState(() {
      _errorLastName = Validator.validate(
        Rule(
          require: true,
        ),
        lastName,
      );
    });
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

  /// Check error
  bool _isError() {
    return _errorFirstName != null ||
        _errorLastName != null ||
        _errorEmail != null ||
        _errorPassword != null ||
        !_agree;
  }

  /// Register
  void _onRegister(BuildContext context) {
    final firstName = _firstNameController.text;
    final lastName = _lastNameController.text;
    final email = _emailController.text;
    final password = _passwordController.text;

    _validateFirstName(firstName);
    _validateLastName(lastName);
    _validateEmail(email);
    _validatePassword(password);

    if (!_isError()) {
      final authentication = context.read<RegisterBloc>();
      authentication.add(
        OnRegister(
          firstName: firstName,
          lastName: lastName,
          email: email,
          password: password,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final error = _isError();
    return BlocProvider(
      create: (context) => RegisterBloc(),
      child: BlocConsumer<RegisterBloc, RegisterState>(
        listener: (context, state) {
          if (state is RegisterSuccess) {
            context.pop({
              "email": _emailController.text,
              "password": _passwordController.text
            });
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text(
                Translate.of(context).translate('register'),
              ),
            ),
            body: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(12),
                    child: Box(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            Translate.of(context).translate('welcome'),
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            Translate.of(context).translate('register_message'),
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                          const SizedBox(height: 12),
                          TextField(
                            controller: _firstNameController,
                            focusNode: _firstNameFocusNode,
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.person_outline),
                              labelText: Translate.of(context).translate(
                                'first_name',
                              ),
                              suffixIcon: IconButton(
                                icon: Icon(Icons.clear),
                                onPressed: () {
                                  _firstNameController.clear();
                                },
                              ),
                              errorText: _errorFirstName,
                            ),
                            onSubmitted: (value) {
                              _lastNameFocusNode.requestFocus();
                            },
                            onChanged: _validateFirstName,
                          ),
                          const SizedBox(height: 12),
                          TextField(
                            controller: _lastNameController,
                            focusNode: _lastNameFocusNode,
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.person_outline),
                              labelText: Translate.of(context).translate(
                                'last_name',
                              ),
                              suffixIcon: IconButton(
                                icon: Icon(Icons.clear),
                                onPressed: () {
                                  _lastNameController.clear();
                                },
                              ),
                              errorText: _errorLastName,
                            ),
                            onSubmitted: (value) {
                              _emailFocusNode.requestFocus();
                            },
                            onChanged: _validateLastName,
                          ),
                          const SizedBox(height: 12),
                          TextField(
                            controller: _emailController,
                            focusNode: _emailFocusNode,
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.email_outlined),
                              labelText:
                                  Translate.of(context).translate('email'),
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
                              Checkbox(
                                value: _agree,
                                onChanged: (value) {
                                  setState(() {
                                    _agree = value!;
                                  });
                                },
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      Translate.of(context)
                                          .translate('read_and_accept'),
                                    ),
                                    GestureDetector(
                                      onTap: () {},
                                      child: Text(
                                        Translate.of(context).translate(
                                          'terms_and_privacy_policy',
                                        ),
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall
                                            ?.copyWith(
                                                color: Theme.of(context)
                                                    .primaryColor),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
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
                            onPressed:
                                error ? null : () => _onRegister(context),
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
}
