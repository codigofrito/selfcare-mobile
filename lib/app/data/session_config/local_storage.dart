import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  
  static final _lastSession = 'lastSession';

  static Future<void> setLastSession(String value) async {
    final SharedPreferences _preferences =
        await SharedPreferences.getInstance();
    await _preferences.setString(_lastSession, value);
  }

  static Future<String> getLastSession() async {
    final SharedPreferences _preferences =
        await SharedPreferences.getInstance();
    return _preferences.getString(_lastSession);
  }
}
