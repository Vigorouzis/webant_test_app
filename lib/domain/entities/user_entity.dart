class UserEntity {
  final String name;
  String birthday;
  final String? email;
  final String? phone;
  final String? password;
  final String username;
  List<String?>? uploadImages;

  UserEntity({
    required this.name,
    required this.birthday,
    required this.uploadImages,
    this.email,
    this.phone,
    this.password,
    required this.username,
  });
}
