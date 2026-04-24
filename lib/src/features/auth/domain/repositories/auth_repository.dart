import '../entities/user_entity.dart';

abstract class AuthRepository {
  Future<void> login(UserEntity user);
  Future<bool> isLoggedIn();
  Future<void> logout();
}
