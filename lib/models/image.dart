
import 'package:json_annotation/json_annotation.dart';

part 'image.g.dart';

@JsonSerializable()
class ImageModel {
  final String? name;
   String? dateCreate;
  final String? user;
  final String? description;

  ImageModel(
      {required this.name,
      required this.dateCreate,
      required this.user,
      required this.description});

  factory ImageModel.fromJson(Map<String, dynamic> json) => _$ImageModelFromJson(json);
}
