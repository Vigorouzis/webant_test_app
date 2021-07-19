import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:webant_test_app/domain/entities/image_entity.dart';

part 'image.g.dart';

@JsonSerializable()
@HiveType(typeId: 1)
class ImageModel extends ImageEntity {
  @HiveField(0)
  String? name;
  @HiveField(1)
  DateTime? dateCreate;
  @HiveField(2)
  String? user;
  @HiveField(3)
  String? description;

  ImageModel(
      {required this.name,
      required this.dateCreate,
      required this.user,
      required this.description})
      : super(
            name: name,
            dateCreate: dateCreate,
            user: user,
            description: description);

  factory ImageModel.fromJson(Map<String, dynamic> json) =>
      _$ImageModelFromJson(json);
}
