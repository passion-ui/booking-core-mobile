import 'dart:developer' as developer;

import 'package:booking/core/core.dart';

class Logger {
  static log([String tag = "LOGGER", dynamic msg]) {
    if (Application.debug) {
      developer.log('${msg ?? ''}', name: tag);
    }
  }

  static final _instance = Logger._internal();

  factory Logger() {
    return _instance;
  }

  Logger._internal();
}
