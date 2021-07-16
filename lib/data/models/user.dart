import 'dart:io';

import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:webant_test_app/domain/entities/user_entity.dart';

part 'user.g.dart';

@JsonSerializable()
@HiveType(typeId: 0)
class User extends UserEntity {
  @HiveField(0)
  final String? name;
  @HiveField(1)
  DateTime? birthday;
  @HiveField(2)
  final String? email;
  @HiveField(3)
  final String? phone;
  @HiveField(4)
  final String? password;
  @HiveField(5)
  final String? username;
  @HiveField(6)
  List<String?>? uploadImages;
  File? avatar;

  User({
    this.name,
    this.birthday,
    this.uploadImages,
    this.email,
    this.phone,
    this.password,
    this.username,
    this.avatar,
  }) : super(
            birthday: birthday,
            username: username,
            name: name,
            uploadImages: uploadImages,
            email: email,
            phone: phone,
            password: password,
            avatar: avatar);

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
