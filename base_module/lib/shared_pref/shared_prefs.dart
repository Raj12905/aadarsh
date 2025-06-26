import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../app_models/user_login_model_response.dart';

class SharedPrefs {
  static const String _userIdKey = 'userId';
  static const String _isLoggedInKey = 'isLoggedIn';
  static const String _initialProfileKey = 'initialProfileKey';
  static const String _isSuperAdminKey = 'isSuperAdminKey';
  static const String _oneSignal = 'OneSignal';
  static const String _userType = 'userType';
  static const String _userData = 'userData';
  static const String _userBaseUrl = 'userBaseUrl';
  static const String _addressData = 'addressData';

  Future<void> setUserId(String userId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_userIdKey, userId);
  }

  Future<String?> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_userIdKey);
  }

  Future<void> setOneSignalId(String? userId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_oneSignal, userId ?? '');
  }

  getOneSignalId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_oneSignal);
  }

  Future<void> setUserType(String? userType) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_userType, userType ?? '');
  }

  getUserType() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_userType);
  }

  Future<LoginData> getUserData() async {
    final prefs = await SharedPreferences.getInstance();
    final userDataString = prefs.getString(_userData);
    final Map<String, dynamic> decodedJson = jsonDecode(userDataString!);
    print("mjighuifg");
    print(decodedJson);
    return LoginData.fromJson(decodedJson);
  }


  Future<void> setUserData(LoginData? user) async {
    final prefs = await SharedPreferences.getInstance();
    var encode = jsonEncode(user);
    await prefs.setString(_userData, encode);
  }

  // IsLoggedIn
  Future<void> setIsLoggedIn(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_isLoggedInKey, value);
  }

  Future<bool> getIsLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_isLoggedInKey) ?? false;
  }

  // IsLoggedIn
  Future<void> setInitialProfileDone(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_initialProfileKey, value);
  }

  Future<bool> getInitialProfileDone() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_initialProfileKey) ?? false;
  }

  // IsLoggedIn
  Future<void> setIsSuperAdmin(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_isSuperAdminKey, value);
  }

  Future<bool> getSuperAdmin() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_isSuperAdminKey) ?? false;
  }

  // Clear all preferences
  Future<void> clear() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
