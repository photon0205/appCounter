// ignore_for_file: unused_element

import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  static late SharedPreferences _preferences;
  static late LocalStorageService _instance;

  static Future<LocalStorageService> getInstance() async {
    _instance = LocalStorageService();
    _preferences = await SharedPreferences.getInstance();
    return _instance;
  }

  _saveToDisk(value) {
    _preferences.setInt('state', value);
  }

  _getFromDisk() {
    final value = _preferences.get('state');
    if (value == null) {
      return 0;
    }
    return value;
  }

  void setCounter(int value) {
    print("kjdvjkdhvkjh");
    _saveToDisk(value);
  }

  int getCounter() {
    print("kjdvjkdhvkjhknjacbbhhjb");
    return _getFromDisk();
  }
}
