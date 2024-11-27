import 'package:booking/domain/domain.dart';
import 'package:booking/presentation/presentation.dart';

class ForgotBloc extends Bloc<ForgotEvent, ForgotState> {
  final _forgot = ForgotPasswordUseCase(sl());
  final MessageBloc _messageBloc = sl();

  ForgotBloc() : super(ForgotInitial()) {
    ///Authentication register event
    on<OnForgotPassword>((event, emit) async {
      try {
        await _forgot.call(email: event.email);
        emit(ForgotPasswordSuccess());
      } on Exception catch (error) {
        _messageBloc.add(
          OnMessage(title: error.toString().replaceAll("Exception: ", "")),
        );
      }
    });
  }
}
