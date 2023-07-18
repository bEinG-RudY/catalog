import 'package:catalog/data/contact.dart';
import 'package:catalog/ui/contact/widget/contact_form.dart';
import 'package:flutter/material.dart';

class ContactEditPage extends StatelessWidget {
  final Contact editedContact;

  const ContactEditPage({Key? key, required this.editedContact})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Contact"),
      ),
      body: ContactForm(
        editedContact: editedContact,
      ),
    );
  }
}
