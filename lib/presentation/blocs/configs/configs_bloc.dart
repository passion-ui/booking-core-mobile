import 'package:booking/core/core.dart';
import 'package:booking/presentation/presentation.dart';

class ConfigsBloc extends Bloc<ConfigsEvent, ConfigsState> {
  ConfigsBloc() : super(ConfigsInitial()) {
    on<SyncConfigs>((event, emit) {
      Logger.log('ConfigsSync');
    });
  }
}
