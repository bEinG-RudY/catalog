import 'package:catalog/data/contact.dart';
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
          return new ContactTile(contacts: _contacts);
        }),
      ),
    );
  }
}
