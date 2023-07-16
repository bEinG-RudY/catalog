import 'dart:io';

class Contact {
  late String name;
  late String email;
  late String phoneNumber;
  bool isFavorite;
  File? imageFile;

  Contact({
    required this.name,
    required this.email,
    required this.phoneNumber,
    this.isFavorite = false,
    this.imageFile,
  });
}
