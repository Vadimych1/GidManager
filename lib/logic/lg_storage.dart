import "package:flutter_secure_storage/flutter_secure_storage.dart";

class Storage {
  static const storage = FlutterSecureStorage();

  static Future<String> read(String key) async {
    return await storage.read(key: key) ?? "";
  }

  static void write(String key, String value) async {
    await storage.write(key: key, value: value);
  }

  static void delete(String key) async {
    await storage.delete(key: key);
  }

  static void deleteAll() async {
    await storage.deleteAll();
  }

  
}
