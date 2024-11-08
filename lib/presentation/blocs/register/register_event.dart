class RegisterEvent {}

class OnRegister extends RegisterEvent {
  final String firstName;
  final String lastName;
  final String email;
  final String password;

  OnRegister({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
  });
}
