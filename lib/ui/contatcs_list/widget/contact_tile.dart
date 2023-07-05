import 'package:flutter/material.dart';

import '../../../data/contact.dart';

class ContactTile extends StatelessWidget {
  const ContactTile({
    Key? key,
    required List<Contact> contacts,
  })  : _contacts = contacts,
        super(key: key);
  final List<Contact> _contacts;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(_contacts[index].name),
      subtitle: Text(_contacts[index].email),
      trailing: IconButton(
        icon: Icon(_contacts[index].isFavorite ? Icons.star : Icons.star_border,
            color: _contacts[index].isFavorite ? Colors.amber : Colors.grey),
        onPressed: () {
          setState(() {
            _contacts[index].isFavorite = !_contacts[index].isFavorite;
            _contacts.sort(((a, b) {
              if (a.isFavorite) {
                return -1;
              } else if (b.isFavorite) {
                return 1;
              } else {
                return 0;
              }
            }));
          });
        },
      ),
    );
  }
}
