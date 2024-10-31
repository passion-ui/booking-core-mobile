import 'package:bloc/bloc.dart';
import 'package:booking/core/core.dart';

import 'configs_event.dart';
import 'configs_state.dart';

class ConfigsBloc extends Bloc<ConfigsEvent, ConfigsState> {
  ConfigsBloc() : super(ConfigsInitial()) {
    on<SyncConfigs>((event, emit) {
      Logger.log('ConfigsSync');
    });
  }
}
