class Contact {
  late String name;
  late String email;
  late String phoneNumber;
  bool isFavorite;

  Contact({
    required this.name,
    required this.email,
    required this.phoneNumber,
    this.isFavorite = false,
  }) {
    int max = 0;
  }
}
