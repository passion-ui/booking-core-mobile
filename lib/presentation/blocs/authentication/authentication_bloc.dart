import 'package:booking/domain/domain.dart';
import 'package:booking/presentation/presentation.dart';

typedef AuthBloc = Bloc<AuthenticationEvent, AuthenticationState>;

class AuthenticationBloc extends AuthBloc {
  final LoginUseCase _login;
  final MessageBloc _messageBloc;

  AuthenticationBloc(this._login, this._messageBloc)
      : super(AuthenticationInitial()) {
    ///Authentication verify event
    on<AuthenticationVerify>((event, emit) {
      emit(AuthenticationFail());
    });

    ///Authentication logged in event
    on<AuthenticationLoggedIn>((event, emit) async {
      try {
        final user = await _login.call(event.username, event.password);
        emit(AuthenticationSuccess(user: user));
      } on Exception catch (error) {
        _messageBloc.add(
          OnMessage(title: error.toString().replaceAll("Exception: ", "")),
        );
      }
    });

    ///Authentication logged out event
    on<AuthenticationLoggedOut>((event, emit) {
      emit(AuthenticationFail());
    });
  }
}
