import 'package:booking/domain/domain.dart';
import 'package:booking/presentation/presentation.dart';

class ChangePasswordCubit extends Cubit<ChangePasswordState> {
  final changePasswordUseCase = ChangePasswordUseCase(sl());
  final MessageBloc _messageBloc = sl();

  ChangePasswordCubit() : super(ChangePasswordInitial());

  Future<void> changePassword({
    required String oldPassword,
    required String newPassword,
  }) async {
    try {
      await changePasswordUseCase.call(
        oldPassword: oldPassword,
        newPassword: newPassword,
      );
      emit(ChangePasswordSuccess());
      _messageBloc.add(OnMessage(title: "change_password_success"));
    } catch (error) {
      _messageBloc.add(
        OnMessage(title: error.toString().replaceAll("Exception: ", "")),
      );
    }
  }
}
