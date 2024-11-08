class AuthenticationEvent {}

class OnVerify extends AuthenticationEvent {}

class OnLogIn extends AuthenticationEvent {
  final String username;
  final String password;

  OnLogIn({
    required this.username,
    required this.password,
  });
}

class OnLogOut extends AuthenticationEvent {}
