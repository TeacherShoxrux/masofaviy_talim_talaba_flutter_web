import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  static String? role='admin';

  static Future<void> saveRole(String newRole) async {
    role = newRole;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("role", newRole);
  }

  static Future<void> loadRole() async {
    final prefs = await SharedPreferences.getInstance();
    role = prefs.getString("role");
  }

  static Future<void> clearRole() async {
    role = null;
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove("role");
  }
}
