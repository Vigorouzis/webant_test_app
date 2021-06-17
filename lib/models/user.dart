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

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['fullName'],
      birthday: json['birthday'],
      email: json['email'],
      password: json['password'],
      phone: json['phone'],
      username: json['username'],
      uploadImages: json['uploadImages'],
    );
  }
}
