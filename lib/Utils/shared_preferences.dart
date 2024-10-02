// Package imports:
import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  static SharedPreferences? prefs;

  ///get instance of the shared preferences
  static Future<void> getInstance() async {
    prefs = await SharedPreferences.getInstance();
  }

  //Set preferences
  ///set user logged in or not and user id in local
  static setLoginAndUserId(String userId) {
    prefs!.setBool("isLoggedIn", true);
    prefs!.setString("userId", userId);
  }

  ///set user logged out
  static setLogOut() {
    prefs!.setBool("isLoggedIn", false);
    prefs!.setString("userId", '');
  }

  ///set first time as false
  static setFirstAsFalse() {
    prefs!.setBool("isFirstTime", false);
  }

  //get preferences
  ///set first time as false
  static bool getFirstTime() {
    bool? isFirst = prefs!.getBool("isFirstTime");
    return isFirst ?? true;
  }

  ///get user logged in or not
  static bool getLogin() {
    bool? login = prefs!.getBool("isLoggedIn");
    return login ?? false;
  }

  ///get user logged in or not
  static String getUserId() {
    String? userId = prefs!.getString("userId");
    return userId ?? "";
  }
}
