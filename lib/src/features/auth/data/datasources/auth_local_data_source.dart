import 'package:shared_preferences/shared_preferences.dart';

import '../models/user_model.dart';

class AuthLocalDataSource {
  AuthLocalDataSource(this.sf);

  static const _tokenKey = 'auth_token';

  final SharedPreferences sf;

  Future<UserModel> login(UserModel user) async {
    await Future.delayed(const Duration(milliseconds: 500));

    const id = 'u-001';
    await sf.setString(_tokenKey, '$id-dummy token');

    return UserModel(id: id, email: user.email, password: user.password);
  }

  Future<bool> isLoggedIn() async {
    final token = sf.getString(_tokenKey);
    return token == null ? false : true;
  }

  Future<void> logout() async {
    await sf.remove(_tokenKey);
  }
}
