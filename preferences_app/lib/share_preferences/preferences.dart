import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  static late SharedPreferences _prefs;

  static String _name = '';
  static bool _isDarkmode = false;
  static int _gender = 1;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }
}
