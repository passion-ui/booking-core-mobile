import 'package:booking/domain/domain.dart';
import 'package:booking/presentation/presentation.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final _register = RegisterUseCase(sl());
  final MessageBloc _messageBloc = sl();

  RegisterBloc() : super(RegisterInitial()) {
    ///Authentication register event
    on<OnRegister>((event, emit) async {
      try {
        await _register.call(
          firstName: event.firstName,
          lastName: event.lastName,
          email: event.email,
          password: event.password,
        );
        emit(RegisterSuccess());
      } on Exception catch (error) {
        _messageBloc.add(
          OnMessage(title: error.toString().replaceAll("Exception: ", "")),
        );
      }
    });
  }
}
