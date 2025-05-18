import 'package:booking/presentation/presentation.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final _changePasswordCubit = ChangePasswordCubit();
  final _formKey = GlobalKey<FormState>();

  final _oldPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _oldPasswordFocusNode = FocusNode();
  final _newPasswordFocusNode = FocusNode();

  bool _secure = true;

  @override
  void dispose() {
    _changePasswordCubit.close();
    _oldPasswordController.dispose();
    _newPasswordController.dispose();
    _oldPasswordFocusNode.dispose();
    _newPasswordFocusNode.dispose();
    super.dispose();
  }

  void _onSubmit() {
    if (_formKey.currentState?.validate() != true) {
      return;
    }
    final oldPassword = _oldPasswordController.text;
    final newPassword = _newPasswordController.text;
    _changePasswordCubit.changePassword(
      oldPassword: oldPassword,
      newPassword: newPassword,
    );
  }

  ///Re Login after change password
  void _reLogin() {
    context.read<AuthenticationBloc>().add(OnLogOut());
    context.replace(Routers.login);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _changePasswordCubit,
      child: Scaffold(
        appBar: AppBar(
          title: Text(Translate.of(context).translate('change_password')),
        ),
        body: BlocListener<ChangePasswordCubit, ChangePasswordState>(
          listener: (context, state) {
            if (state is ChangePasswordSuccess) {
              _reLogin();
            }
          },
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Box(
              child: Form(
                autovalidateMode: AutovalidateMode.always,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      Translate.of(context).translate(
                        'change_password_message',
                      ),
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _oldPasswordController,
                      focusNode: _oldPasswordFocusNode,
                      obscureText: _secure,
                      validator: FormBuilderValidators.required(),
                      decoration: InputDecoration(
                        labelText: Translate.of(context).translate(
                          'old_password',
                        ),
                        prefixIcon: Icon(Icons.lock_outline),
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _newPasswordController,
                      focusNode: _newPasswordFocusNode,
                      obscureText: _secure,
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(),
                        FormBuilderValidators.minLength(6),
                      ]),
                      decoration: InputDecoration(
                        labelText: Translate.of(context).translate(
                          'new_password',
                        ),
                        prefixIcon: Icon(Icons.lock_outline),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Checkbox(
                          value: !_secure,
                          onChanged: (value) {
                            setState(() {
                              _secure = !(value ?? false);
                            });
                          },
                        ),
                        Text(Translate.of(context).translate('show_password')),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: FilledButton(
                            onPressed: _onSubmit,
                            child: Text(
                              Translate.of(context).translate(
                                'change_password',
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
