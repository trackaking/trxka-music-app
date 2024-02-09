import 'package:shared_preferences/shared_preferences.dart';

class HelperFunctions {
  final Future<SharedPreferences> _preferences =
      SharedPreferences.getInstance();

  //keys
  final String _userLoggedInKey = "LOGGEDINKEY";
  final String userNameKey = "USERNAMEKEY";
  final String userEmailKey = "USEREMAILKEY";
  String token = "";

  Future<bool?> getUserLoggedInStatus() async {
    final SharedPreferences prefs = await _preferences;
    return prefs.getBool(_userLoggedInKey);
  }

  Future setToken(String token) async {
    final SharedPreferences prefs = await _preferences;
    await prefs.setString(_userLoggedInKey, token);
  }

  Future getToken() async {
    final SharedPreferences prefs = await _preferences;
    token = prefs.getString(_userLoggedInKey)!;
    return token;
  }

  Future removeToken() async {
    final SharedPreferences prefs = await _preferences;
    await prefs.remove(_userLoggedInKey);
  }
}
