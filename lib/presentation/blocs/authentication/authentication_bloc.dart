import 'package:booking/domain/domain.dart';
import 'package:booking/presentation/presentation.dart';

typedef AuthBloc = Bloc<AuthenticationEvent, AuthenticationState>;

class AuthenticationBloc extends AuthBloc {
  final _login = LoginUseCase(sl());
  final _getUserData = GetUserDataUseCase(sl());
  final _clearUserData = ClearUserDataUseCase(sl());
  final MessageBloc _messageBloc = sl();

  AuthenticationBloc() : super(AuthenticationInitial()) {
    ///Authentication verify event
    on<OnVerify>((event, emit) async {
      try {
        final user = await _getUserData.call();
        if (user == null) {
          emit(AuthenticationFail());
        } else {
          emit(AuthenticationSuccess(user: user));
        }
      } on Exception catch (error) {
        _messageBloc.add(
          OnMessage(title: error.toString().replaceAll("Exception: ", "")),
        );
        emit(AuthenticationFail());
      }
    });

    ///Authentication logged in event
    on<OnLogIn>((event, emit) async {
      try {
        final user = await _login.call(
          username: event.username,
          password: event.password,
        );
        emit(AuthenticationSuccess(user: user));
      } on Exception catch (error) {
        _messageBloc.add(
          OnMessage(title: error.toString().replaceAll("Exception: ", "")),
        );
      }
    });

    ///Authentication logged out event
    on<OnLogOut>((event, emit) async {
      try {
        await _clearUserData.call();
      } on Exception catch (error) {
        _messageBloc.add(
          OnMessage(title: error.toString().replaceAll("Exception: ", "")),
        );
      } finally {
        emit(AuthenticationFail());
      }
    });
  }
}
