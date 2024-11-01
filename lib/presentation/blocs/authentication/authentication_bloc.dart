import 'package:bloc/bloc.dart';

import 'authentication_event.dart';
import 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc() : super(AuthenticationInitial()) {
    ///Authentication verify event

    on<AuthenticationVerify>((event, emit) {});

    ///Authentication logged in event
    on<AuthenticationLoggedIn>((event, emit) {});
  }
}
