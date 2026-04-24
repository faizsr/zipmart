import 'package:zipmart/src/features/auth/data/models/user_model.dart';

class UserEntity {
  const UserEntity({this.id = '', required this.email, required this.password});

  final String id;
  final String email;
  final String password;

  UserModel toModel() {
    return UserModel(id: id, email: email, password: password);
  }
}
