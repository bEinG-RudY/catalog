import 'dart:io';

class Contact {
  // Database id(key)
  int? id;

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

  Map<String, dynamic> toMap() {
    // Mpa litrals are created with curly braces{}
    return {
      'name': name,
      'email': email,
      'phoneNumber': phoneNumber,
      'isFavorite': isFavorite,
      // We cannot store a file object in with SEMBAST library directly.
      // That's why we only store its path
      'imageFilePath': imageFile?.path,
    };
  }

  static Contact fromMap(Map<String, dynamic> map) {
    return Contact(
        name: map['name'],
        email: map['email'],
        phoneNumber: map['phoneNumber'],
        isFavorite: map['isFavorite'],
        imageFile:
            map['imageFilePath'] != null ? File(map['imageFilePath']) : null);
  }
}
