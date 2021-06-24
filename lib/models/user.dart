import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  final String name;
  final String birthday;
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
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
