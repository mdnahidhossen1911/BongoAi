import 'package:shared_preferences/shared_preferences.dart';

import '../models/auth_user.dart';

class AuthService {
  static const _keyUuid = 'uuid';
  static const _keyName = 'name';
  static const _keyImage = 'image';
  static const _keyBehavior = 'behavior';

  static final AuthService _instance = AuthService._internal();
  factory AuthService() => _instance;
  AuthService._internal();

  AuthUser? _user;

  Future<void> save({
    required String uuid,
    required String name,
    String? image,
    String? behavior,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    _user = AuthUser(uuid: uuid, name: name, image: image, behavior: behavior);
    await prefs.setString(_keyUuid, uuid);
    await prefs.setString(_keyName, name);
    if (image != null) {
      await prefs.setString(_keyImage, image);
    } else {
      await prefs.remove(_keyImage);
    }
    if (behavior != null) {
      await prefs.setString(_keyBehavior, behavior);
    } else {
      await prefs.remove(_keyBehavior);
    }
  }

  Future<void> update({String? name, String? image, String? behavior}) async {
    final prefs = await SharedPreferences.getInstance();
    if (_user == null) return;
    _user = AuthUser(
      uuid: _user!.uuid,
      name: name ?? _user!.name,
      image: image ?? _user!.image,
      behavior: behavior ?? _user!.behavior,
    );
    if (name != null) {
      await prefs.setString(_keyName, name);
    }
    if (image != null) {
      await prefs.setString(_keyImage, image);
    } else if (_user!.image == null) {
      await prefs.remove(_keyImage);
    }
    if (behavior != null) {
      await prefs.setString(_keyBehavior, behavior);
    } else if (_user!.behavior == null) {
      await prefs.remove(_keyBehavior);
    }
  }

  Future<AuthUser?> getData() async {
    final prefs = await SharedPreferences.getInstance();
    final uuid = prefs.getString(_keyUuid);
    final name = prefs.getString(_keyName);
    if (uuid == null || name == null) return null;
    final image = prefs.getString(_keyImage);
    final behavior = prefs.getString(_keyBehavior);
    _user = AuthUser(uuid: uuid, name: name, image: image, behavior: behavior);
    return _user;
  }

  Future<bool> isLogin() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyUuid) != null;
  }

  Future<void> logOut() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_keyName);
    await prefs.remove(_keyImage);
    await prefs.remove(_keyBehavior);
    await prefs.remove(_keyUuid);
    _user = null;
  }

  AuthUser? get user => _user;
}
