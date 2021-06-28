import 'package:json_annotation/json_annotation.dart';
import 'package:webant_test_app/domain/entities/user_entity.dart';

part 'user.g.dart';

@JsonSerializable()
class User extends UserEntity {
  final String name;
  String birthday;
  final String? email;
  final String? phone;
  final String? password;
  final String username;
  List<String?>? uploadImages;

  User({
    required this.name,
    required this.birthday,
    required this.uploadImages,
    this.email,
    this.phone,
    this.password,
    required this.username,
  }) : super(
            birthday: birthday,
            username: username,
            name: name,
            uploadImages: uploadImages,
            email: email,
            phone: phone,
            password: password);

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
