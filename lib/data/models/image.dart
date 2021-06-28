import 'package:json_annotation/json_annotation.dart';
import 'package:webant_test_app/domain/entities/image_entity.dart';

part 'image.g.dart';

@JsonSerializable()
class ImageModel extends ImageEntity {
  String? name;
  String? dateCreate;
  String? user;
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
