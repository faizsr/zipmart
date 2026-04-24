import '../entities/user_entity.dart';
import '../repositories/auth_repository.dart';

class LoginUsecase {
  LoginUsecase(this._repository);

  final AuthRepository _repository;

  Future<bool> call(UserEntity user) {
    return _repository.login(user);
  }
}
