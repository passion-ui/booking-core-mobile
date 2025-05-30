import 'package:bloc/bloc.dart';
import 'package:booking/core/core.dart';

class AppBlocObserver extends BlocObserver {
  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    Logger.log('onCreate', bloc.runtimeType);
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    Logger.log("onChange", '${bloc.runtimeType} -- $change');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    Logger.log('onError', '${bloc.runtimeType} -- $error');
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onClose(BlocBase bloc) {
    super.onClose(bloc);
    Logger.log('onClose', bloc.runtimeType);
  }
}
