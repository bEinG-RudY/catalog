import 'package:catalog/data/contact.dart';
import 'package:catalog/ui/contatcs_list/widget/contact_tile.dart';
import 'package:faker/faker.dart';
import 'package:flutter/material.dart';

class ContactsListPage extends StatefulWidget {
  @override
  State<ContactsListPage> createState() => _ContactsListPageState();
}

class _ContactsListPageState extends State<ContactsListPage> {
  late List<Contact> _contacts;

  @override
  void initState() {
    super.initState();
    _contacts = List.generate(50, (index) {
      return Contact(
          name: faker.person.firstName() + " " + faker.person.lastName(),
          email: faker.internet.freeEmail(),
          phoneNumber: faker.randomGenerator.integer(1000000000).toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Contacts"),
      ),
      body: ListView.builder(
        itemCount: _contacts.length,
        itemBuilder: ((context, index) {
          return new ContactTile(
            contact: _contacts[index],
            onFavoritePressed: () {
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
          );
        }),
      ),
    );
  }
}
