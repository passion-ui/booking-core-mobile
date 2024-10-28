import 'dart:convert';

import 'package:flutter/services.dart';

class AssetUtils {
  static Future<Map<String, dynamic>> loadJson(String path) async {
    String content = await rootBundle.loadString(path);
    return jsonDecode(content);
  }
}
