import '../../domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
    required super.id,
    required super.email,
    required super.password,
  });

  factory UserModel.fromJson(UserModel user) {
    return UserModel(id: 'u-001', email: user.email, password: user.password);
  }

  UserEntity toEntity() {
    return UserEntity(
      id: id,
      email: email,
      password: password,
    );
  }
}
