import 'package:booking/domain/domain.dart';

class AuthenticationState {}

class AuthenticationInitial extends AuthenticationState {}

class AuthenticationFail extends AuthenticationState {}

class AuthenticationSuccess extends AuthenticationState {
  final UserEntity user;

  AuthenticationSuccess({required this.user});
}
