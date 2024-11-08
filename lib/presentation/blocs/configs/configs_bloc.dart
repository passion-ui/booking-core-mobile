import 'package:booking/domain/domain.dart';
import 'package:booking/presentation/presentation.dart';

class ConfigsBloc extends Bloc<ConfigsEvent, ConfigsState> {
  final _messageBloc = sl<MessageBloc>();
  final _syncConfigs = SyncConfigUseCase(sl());

  ConfigsBloc() : super(ConfigsInitial()) {
    on<SyncConfigs>((event, emit) async {
      try {
        // final config = await _syncConfigs.call((config) {
        //   emit(ConfigsSuccess(config: config));
        // });
        // emit(ConfigsSuccess(config: config));
      } on Exception catch (error) {
        _messageBloc.add(
          OnMessage(title: error.toString().replaceAll("Exception: ", "")),
        );
      }
    });
  }
}
