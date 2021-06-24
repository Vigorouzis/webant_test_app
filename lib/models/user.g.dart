// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User(
    name: json['name'] as String,
    birthday: json['birthday'] as String,
    uploadImages: (json['uploadImages'] as List<dynamic>?)
        ?.map((e) => e as String?)
        .toList(),
    email: json['email'] as String?,
    phone: json['phone'] as String?,
    password: json['password'] as String?,
    username: json['username'] as String,
  );
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'name': instance.name,
      'birthday': instance.birthday,
      'email': instance.email,
      'phone': instance.phone,
      'password': instance.password,
      'username': instance.username,
      'uploadImages': instance.uploadImages,
    };
