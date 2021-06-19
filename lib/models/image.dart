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

  factory ImageModel.fromJson(Map<String, dynamic> json) {
    return ImageModel(
      user: json['user'],
      description: json['description'],
      name: json['image']['name'],
      dateCreate: json['dateCreate'],
    );
  }
}
