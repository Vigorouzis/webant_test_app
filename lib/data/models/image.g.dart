// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'image.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ImageModel _$ImageModelFromJson(Map<String, dynamic> json) {
  return ImageModel(
    name: json['image']['name'] as String?,
    dateCreate: json['dateCreate'] as String?,
    user: json['user'] as String?,
    description: json['description'] as String?,
  );
}

Map<String, dynamic> _$ImageModelToJson(ImageModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'dateCreate': instance.dateCreate,
      'user': instance.user,
      'description': instance.description,
    };
