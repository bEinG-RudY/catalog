import 'package:catalog/ui/contatcs_list/contacts_list_page.dart';
import 'package:catalog/ui/model/contacts_model.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScopedModel(
      // Load all contacts from the database as soon as the app starts
      model: ContactModel()..loadContacts(),
      child: MaterialApp(
        title: 'Contacts',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: ContactsListPage(),
      ),
    );
  }
}
