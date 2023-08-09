import 'package:shared_preferences/shared_preferences.dart';

class sharedPrefrences {
  Future<void> setAdminLogin(bool value) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setBool("login", value);
  }

  Future<bool> isAdminLogin() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    return sp.getBool('login') ?? false;
  }
}
