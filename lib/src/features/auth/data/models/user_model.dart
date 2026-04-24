import '../../domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
    super.id = '',
    required super.email,
    required super.password,
  });

  factory UserModel.fromStorage({
    required String id,
    required String email,
  }) {
    return UserModel(id: id, email: email, password: '');
  }

  UserEntity toEntity() {
    return UserEntity(
      id: id,
      email: email,
      password: password,
    );
  }
}
