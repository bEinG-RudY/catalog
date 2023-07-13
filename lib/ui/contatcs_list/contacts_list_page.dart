import 'package:catalog/data/contact.dart';
import 'package:catalog/ui/contatcs_list/widget/contact_tile.dart';
import 'package:catalog/ui/model/contacts_model.dart';
import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class ContactsListPage extends StatefulWidget {
  @override
  State<ContactsListPage> createState() => _ContactsListPageState();
}

class _ContactsListPageState extends State<ContactsListPage> {
  ContactModel contacts = new ContactModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Contacts"),
      ),

      // If you need to rebuild the widget tree once the model's data changes
      // you need to use scopedModelDescendant with a builder;
      body: ScopedModelDescendant<ContactModel>(
          builder: ((context, child, model) {
        return ListView.builder(
          itemCount: model.contacts.length,
          itemBuilder: ((context, index) {
            return new ContactTile(
              contactIndex: index,
            );
          }),
        );
      })),
    );
  }
}
