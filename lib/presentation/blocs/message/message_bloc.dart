import 'package:booking/presentation/presentation.dart';

class MessageBloc extends Bloc<MessageEvent, MessageState?> {
  MessageBloc() : super(null) {
    on<OnMessage>((event, emit) {
      emit(MessageState(title: event.title));
    });
  }
}
