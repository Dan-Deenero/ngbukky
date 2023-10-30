import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  //as singleton
  factory SecureStorage() {
    return _instance;
  }
  SecureStorage._internal();

  static final SecureStorage _instance = SecureStorage._internal();

  //To save secure data
  static Future writeSecureData(String key, String value) async {
    const storage = FlutterSecureStorage();
    final writeData = await storage.write(key: key, value: value);
    return writeData;
  }

  //To read the secured data
  static Future readSecureData(String key) async {
    const storage = FlutterSecureStorage();
    final readData = await storage.read(key: key);
    return readData;
  }

  //To delete the secured data
  static Future<void> deleteSecureData() async {
    const storage = FlutterSecureStorage();
    await storage.deleteAll();
  }
}