import 'package:json_annotation/json_annotation.dart';

import '../../features/authentication/domain/entities/user_auth_entity.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  @JsonKey(name: '_id')
  final String id;

  final String username;
  final String firstName;
  final String lastName;
  final String email;
  final String phone;
  final String role;
  final bool isVerified;
  final DateTime createdAt;

  UserModel({
    required this.id,
    required this.username,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.role,
    required this.isVerified,
    required this.createdAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  UserAuthEntity toEntity() {
    return UserAuthEntity(
      id: id,
      username: username,
      firstName: firstName,
      lastName: lastName,
      email: email,
      phone: phone,
      role: role,
      isVerified: isVerified,
      createdAt: createdAt,
    );
  }
}
