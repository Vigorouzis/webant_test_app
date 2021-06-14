class User {
  final String? name;
  final String? birthday;
  final String? email;
  final String? phone;
  final String? password;
  final String? username;

  User({
    this.name,
    this.birthday,
    this.email,
    this.phone,
    this.password,
    this.username,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'],
      birthday: json['birthday'],
      email: json['email'],
      password: json['password'],
      phone: json['phone'],
      username: json['username'],
    );
  }
}
