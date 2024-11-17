import 'package:booking/domain/domain.dart';
import 'package:booking/presentation/presentation.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final _messageBloc = sl<MessageBloc>();
  final _loadHome = LoadHomeUseCase(sl());
  HomeBloc() : super(HomeInitial()) {
    on<OnLoad>((event, emit) async {
      try {
        final data = await _loadHome.call();
        emit(HomeSuccess(data: data));
      } on Exception catch (error) {
        _messageBloc.add(
          OnMessage(title: error.toString().replaceAll("Exception: ", "")),
        );
      }
    });
  }
}
