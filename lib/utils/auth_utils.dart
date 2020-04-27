import 'package:shared_preferences/shared_preferences.dart';

class AuthUtils {
  // Keys to store and fetch data from SharedPreferences
  static final String authTokenKey = 'access_token';
  static final String authMessage = 'message';

  static final String endPoint = '/auth/login';

//token getter...
  static String getToken(SharedPreferences prefs) {
    return prefs.getString(authTokenKey);
  }

  static insertDetails(SharedPreferences prefs, var response) {
    prefs.setString(authTokenKey,response['access_token']);
  }
}
