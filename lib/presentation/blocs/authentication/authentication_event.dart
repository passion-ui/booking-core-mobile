class AuthenticationEvent {}

class AuthenticationVerify extends AuthenticationEvent {}

class AuthenticationLoggedIn extends AuthenticationEvent {
  final String username;
  final String password;

  AuthenticationLoggedIn({
    required this.username,
    required this.password,
  });
}

class AuthenticationLoggedOut extends AuthenticationEvent {}
