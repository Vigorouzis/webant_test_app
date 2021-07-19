import 'package:hive/hive.dart';

class ImageEntity extends HiveObject{
  final String? name;
  DateTime? dateCreate;
  final String? user;
  final String? description;

  ImageEntity(
      {required this.name,
      required this.dateCreate,
      required this.user,
      required this.description});
}
