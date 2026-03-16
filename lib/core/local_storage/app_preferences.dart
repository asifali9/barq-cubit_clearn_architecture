import 'package:shared_preferences/shared_preferences.dart';

class AppPreferences{
  final SharedPreferences _preferences;
  AppPreferences(this._preferences);

  static const String _token = 'token';
  static const String keyIsIntroduced = 'introduced';
  static const String keyIsGuest = 'guest';

  Future<void> saveToken(String value) async {
    await _preferences.setString(_token, value);
  }

  Future<String> getTokent() async {
    return _preferences.getString(_token)??'';
  }

  Future<void> saveIsAppIntroduced(bool isIntroduced) async {
    await _preferences.setBool(keyIsIntroduced, isIntroduced);
  }

  bool getIsAppIntroduced() {
    return _preferences.getBool(keyIsIntroduced) ?? false;
  }

  Future<void> saveIsGuest(bool isGuest) async {
    await _preferences.setBool(keyIsGuest, isGuest);
  }

  bool getIsGuest() {
    return _preferences.getBool(keyIsGuest) ?? false;
  }
}