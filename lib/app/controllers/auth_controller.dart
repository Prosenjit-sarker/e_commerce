import 'dart:convert';

import 'package:crafty_bay/features/auth/data/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController {
  static UserModel? userModel;
  static String? token;

  static const String _tokenKey = 'token';
  static const String _userKey = 'user';

  static Future<void> saveUserData(
    String newToken,
    UserModel newUserData,
  ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, newToken);
    await prefs.setString(_userKey, jsonEncode(newUserData.toJson()));

    token = newToken;
    userModel = newUserData;
  }
  static Future<void> getUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString(_tokenKey);
    final String? userData = prefs.getString(_userKey);
    if (userData != null) {
      userModel = UserModel.fromJson(jsonDecode(userData));
    }
  }

  static Future<bool> isUserAlreadyLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? savedToken = prefs.getString(_tokenKey);
    return savedToken != null && savedToken.isNotEmpty;
  }

  static Future<void> clearUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);
    await prefs.remove(_userKey);
    token = null;
    userModel = null;
  }
}
