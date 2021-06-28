import 'dart:io';

abstract class SendImageEvent {
  const SendImageEvent();
}

class SendImage extends SendImageEvent {
  final File? file;

  final String? name;
  final String? description;
  final bool? newImage;
  final bool? popularImage;

  const SendImage(
      {this.file,
      this.name,
      this.description,
      this.newImage,
      this.popularImage});
}
