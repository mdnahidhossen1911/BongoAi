import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/auth_user.dart';

class AuthService {
  static const _keyUuid = 'uuid';
  static const _keyUser = 'user';

  static final AuthService _instance = AuthService._internal();
  factory AuthService() => _instance;
  AuthService._internal();

  AuthUser? _user;
  String? _uuid;

  Future<void> save({required AuthUser user}) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyUuid, user.uuid ?? '');
    await prefs.setString(_keyUser, jsonEncode(user.toJson()));
    _user = user;
    _uuid = _user?.uuid;
  }

  Future<AuthUser?> getData() async {
    final prefs = await SharedPreferences.getInstance();
    final userInfo = prefs.getString(_keyUser);
    if (userInfo != null) {
      _user = AuthUser.fromJson(jsonDecode(userInfo));
      _uuid = _user?.uuid;
    }
    return _user;
  }

  Future<bool> isLogin() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    String? userid = sharedPreferences.getString(_keyUuid);
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
    _user = null;
    _uuid = null;
  }

  AuthUser? get user => _user;
  String? get uuid => _uuid;
}
