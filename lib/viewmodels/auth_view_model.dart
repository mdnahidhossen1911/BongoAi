import 'dart:convert';

import 'package:bongoai/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/app_logger.dart';

class AuthViewModel {
  static String? uid;
  static UserModel? userModel;

  String get getUid => uid ?? '';
  String get getUserName => userModel?.fullName ?? '';
  String get getGmail => userModel?.email ?? '';
  String get getPhoto => userModel?.photo ?? '';

  static const String _uidKey = 'uidKey';
  static const String _modelKey = 'modelKey';

  Future<void> saveData(String id, UserModel userModel) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_uidKey, userModel.uid ?? '');
    await prefs.setString(_modelKey, jsonEncode(userModel));
    uid = id;
    userModel = userModel;
    appLogger.i("User data saved successfully with email: ${userModel.email}");
    getData();
  }

  Future<void> getData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userDataModel = prefs.getString(_modelKey);
    if (userDataModel != null) {
      userModel = UserModel.fromJson(jsonDecode(userDataModel));
      uid = userModel?.uid;
    }
  }

  Future<bool> isLogIn() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    String? userid = sharedPreferences.getString(_uidKey);
    if (userid != null) {
      getData();
      return true;
    } else {
      return false;
    }
  }

  Future<void> logOut() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    await sharedPreferences.clear();

    userModel = null;
    uid = null;

    appLogger.i("User logged out successfully");
  }
}
