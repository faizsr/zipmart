import '../repositories/auth_repository.dart';

class CheckAuthStatusUsecase {
  CheckAuthStatusUsecase(this._repository);

  final AuthRepository _repository;

  Future<bool> call() {
    return _repository.isLoggedIn();
  }
}
