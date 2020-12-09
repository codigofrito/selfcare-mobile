import 'dart:convert';

import 'package:encrypt/encrypt.dart';
import 'package:selfcare/app/data/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static final _key = Key.fromUtf8(r'v8y/A?D(G+KbPeShVmYq3t6w9z$C&E)H');
  static final _iv = IV.fromLength(16);

  static Future<void> clearSession() async {
    final _preferences = await SharedPreferences.getInstance();
    _preferences.clear();
  }

  static Future<void> setLastSession(User user) async {
    final userData = user?.toMap();

    if (userData != null && userData.isNotEmpty) {
      final encrypter = Encrypter(AES(_key));
      final userDataJsonString = json.encode(userData);
      final encryptedData = encrypter.encrypt(userDataJsonString, iv: _iv);

      final _preferences = await SharedPreferences.getInstance();
      await _preferences.setString('lastSession', encryptedData.base64);
    }
  }

  static Future<User> getLastSession() async {
    final _preferences = await SharedPreferences.getInstance();
    final data = _preferences.getString('lastSession');

    if (data != null && data.isNotEmpty) {
      final encrypter = Encrypter(AES(_key));
      return User.fromJson(json.decode(
        encrypter.decrypt64(data, iv: _iv),
      ) as Map<String, dynamic>);
    }

    return null;
  }
}
