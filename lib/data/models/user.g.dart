// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserAdapter extends TypeAdapter<User> {
  @override
  final int typeId = 0;

  @override
  User read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return User(
      name: fields[0] as String,
      birthday: fields[1] as DateTime,
      uploadImages: (fields[6] as List?)?.cast<String?>(),
      email: fields[2] as String?,
      phone: fields[3] as String?,
      password: fields[4] as String?,
      username: fields[5] as String,
    );
  }

  @override
  void write(BinaryWriter writer, User obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.birthday)
      ..writeByte(2)
      ..write(obj.email)
      ..writeByte(3)
      ..write(obj.phone)
      ..writeByte(4)
      ..write(obj.password)
      ..writeByte(5)
      ..write(obj.username)
      ..writeByte(6)
      ..write(obj.uploadImages);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User(
    name: json['fullName'] as String,
    birthday: json['birthday'] == null ? null : DateTime.parse(json['birthday']),
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
