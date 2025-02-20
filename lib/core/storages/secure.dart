import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  final String userKey = 'user';

  final storage = FlutterSecureStorage();

  /// initialize secure storage
  static SecureStorage init() {
    return SecureStorage();
  }

  /// write to secure storage
  Future<void> write(String key, String value) async {
    return await storage.write(key: key, value: value);
  }

  /// read from secure storage
  Future<String?> read(String key) async {
    return await storage.read(key: key);
  }

  /// delete from secure storage
  Future<void> delete(String key) async {
    return await storage.delete(key: key);
  }

  /// delete all from secure storage
  Future<void> deleteAll() async {
    return await storage.deleteAll();
  }

  /// read all from secure storage
  Future<Map<String, String>> readAll() async {
    return await storage.readAll();
  }

  /// check if key exists in secure storage
  Future<bool> containsKey(String key) async {
    return await storage.containsKey(key: key);
  }
}
