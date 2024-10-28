import 'package:bloc/bloc.dart';
import 'package:booking/presentation/presentation.dart';

import 'injector.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await bindingDependencies();
  Bloc.observer = AppBlocObserver();

  runApp(const App());
}
