import 'package:booking/presentation/presentation.dart';

import 'injector.dart';

Future<void> main() async {
  await bindingDependencies();
  runApp(const App());
}
