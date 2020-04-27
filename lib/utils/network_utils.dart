import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'auth_utils.dart';

class NetworkUtils {
  static final String host = productionHost;
  static final String productionHost =
      'https://law-chamber-api.ocody.com/admin';
  static final String developmentHost = 'http://192.168.31.110:3000';
  //  post request...
  static dynamic authenticateUser(String username, String password) async {
    var uri = host + AuthUtils.endPoint;

    try {
      final response = await http.post(
        uri,
        body: {'username': username, 'password': password},
        headers: {
          'X-Requested-With': 'XMLHttpRequest',
        },
      );

      final responseJson = json.decode(response.body);
      return responseJson;
    } catch (exception) {
      //error handeler
      print(exception);
      if (exception.toString().contains('SocketException')) {
        return 'NetworkError';
      } else {
        return null;
      }
    }
  }

  // what wiill happen on logout
  static logoutUser(BuildContext context, SharedPreferences prefs) {
    prefs.setString(AuthUtils.authTokenKey, null);
    Navigator.of(context).pushReplacementNamed('/');
  }

  // snack Bar...
  static showSnackBar(GlobalKey<ScaffoldState> scaffoldKey, String message) {
    scaffoldKey.currentState.showSnackBar(new SnackBar(
      content: new Text(message ?? 'You are offline'),
      backgroundColor: Colors.pink.withOpacity(.3),
    ));
  }

  ///get request...
  static fetch(var authToken, var endPoint) async {
    var uri = host + endPoint;

    try {
      final response = await http.get(
        uri,
        headers: {
          'Authorization': authToken,
          'X-Requested-With': 'XMLHttpRequest',
        },
      );

      final responseJson = json.decode(response.body);
      return responseJson;
    } catch (exception) {
      print(exception);
      if (exception.toString().contains('SocketException')) {
        return 'NetworkError';
      } else {
        return null;
      }
    }
  }
}
