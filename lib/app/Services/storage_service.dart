import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  static late SharedPreferences _prefs;

  static String? _accessToken;
  static String? _refreshToken;
  static String? _role;

  // INIT (majburiy)
  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // ================= ACCESS TOKEN =================
  static String? get accessToken =>
      _accessToken ??= _prefs.getString('access_token');

  static Future<void> setAccessToken(String? value) async {
    _accessToken = value;
    if (value == null) {
      await _prefs.remove('access_token');
    } else {
      await _prefs.setString('access_token', value);
    }
  }

  // ================= REFRESH TOKEN =================
  static String? get refreshToken =>
      _refreshToken ??= _prefs.getString('refresh_token');

  static Future<void> setRefreshToken(String? value) async {
    _refreshToken = value;
    if (value == null) {
      await _prefs.remove('refresh_token');
    } else {
      await _prefs.setString('refresh_token', value);
    }
  }
  // ================= ROLE =================
  static String? get role =>
      _role ??= _prefs.getString('role');

  static Future<void> setRole(String? value) async {
    _role = value;
    if (value == null) {
      await _prefs.remove('role');
    } else {
      await _prefs.setString('role', value);
    }
  }
  // ================= CLEAR =================
  static Future<void> clear() async {
    _accessToken = null;
    _refreshToken = null;
    _role = null;
    await _prefs.clear();
  }
}
