class ForgotEvent {}

class OnForgotPassword extends ForgotEvent {
  final String email;

  OnForgotPassword({
    required this.email,
  });
}
