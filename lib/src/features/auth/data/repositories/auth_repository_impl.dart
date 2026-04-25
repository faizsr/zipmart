import 'package:zipmart/src/features/auth/domain/entities/user_entity.dart';

import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_local_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl(this._localDataSource);

  final AuthLocalDataSource _localDataSource;

  @override
  Future<bool> isLoggedIn() async {
    return await _localDataSource.isLoggedIn();
  }

  @override
  Future<void> login(UserEntity user) async {
    await _localDataSource.login(user.toModel());
  }

  @override
  Future<void> logout() {
    return _localDataSource.logout();
  }
}
