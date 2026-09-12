import 'package:shared_preferences/shared_preferences.dart';

class SessionRepository {
  static const _keyFirstName = 'firstName';
  static const _keyLastName = 'lastName';

  Future<void> saveSession(String firstName, String lastName) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyFirstName, firstName);
    await prefs.setString(_keyLastName, lastName);
  }

  Future<bool> hasSession() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey(_keyFirstName);
  }

  Future<String?> getFirstName() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyFirstName);
  }

  Future<String?> getLastName() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyLastName);
  }
  Future<void> clearSession() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.clear();
  }
}