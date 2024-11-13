import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  final String userKey = 'user';

  final storage = FlutterSecureStorage();

  static SecureStorage init() {
    return SecureStorage();
  }

  Future<void> write(String key, String value) async {
    return await storage.write(key: key, value: value);
  }

  Future<String?> read(String key) async {
    return await storage.read(key: key);
  }

  Future<void> delete(String key) async {
    return await storage.delete(key: key);
  }

  Future<void> deleteAll() async {
    return await storage.deleteAll();
  }

  Future<Map<String, String>> readAll() async {
    return await storage.readAll();
  }

  Future<bool> containsKey(String key) async {
    return await storage.containsKey(key: key);
  }
}
