import '../models/user_model.dart';

class AuthLocalDataSource {
  Future<bool> login(UserModel user) async {
    await Future<void>.delayed(const Duration(milliseconds: 350));
    return true;
  }
}
