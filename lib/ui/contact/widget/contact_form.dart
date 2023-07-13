import 'package:catalog/data/contact.dart';
import 'package:catalog/ui/model/contacts_model.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class ContactForm extends StatefulWidget {
  const ContactForm({super.key});

  @override
  State<ContactForm> createState() => _ContactFormState();
}

class _ContactFormState extends State<ContactForm> {
  final _formKey = GlobalKey<FormState>();

  late String _name;
  late String _email;
  late String _phoneNumber;

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: ListView(
          children: [
            SizedBox(
              height: 10,
            ),
            TextFormField(
              onSaved: (value) => _name = value!,
              validator: _validateName,
              decoration: InputDecoration(
                  labelText: "Name",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5))),
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              onSaved: (value) => _email = value!,
              validator: _validateEmail,
              decoration: InputDecoration(
                  labelText: "Email",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5))),
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              onSaved: (value) => _phoneNumber = value!,
              validator: _validatePhoneNumber,
              decoration: InputDecoration(
                  labelText: "Phone Number",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5))),
            ),
            ElevatedButton(
                onPressed: _onSaveContactButtonPressed,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [Text("SAVE CONTACT"), Icon(Icons.person)],
                ))
          ],
        ));
  }

  String? _validateEmail(value) {
    final emailRegex = RegExp(
        r"^[a-zA-Z0-9.!#$%&'*+\\/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");
    if (value!.isEmpty) {
      return "Enter the email";
    } else if (!emailRegex.hasMatch(value)) {
      return "Enter a valid email";
    }
    return null;
  }

  String? _validatePhoneNumber(value) {
    // final phoneRegex = RegExp(r'[!@#<>?":_`~;[\]\\|=+)(*&^%0-9-]');
    final phoneRegex =
        RegExp(r'^[\+]?[(]?[0-9]{3}[)]?[-\s\.]?[0-9]{3}[-\s\.]?[0-9]{4,6}$');

    if (value!.isEmpty) {
      return "Enter the phone number";
    } else if (!phoneRegex.hasMatch(value)) {
      return "Enter a valid email";
    }
    return null;
  }

  String? _validateName(value) {
    if (value.isEmpty) {
      return "Please Enter the Name first";
    }

    return null;
  }

  void _onSaveContactButtonPressed() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState?.save();
      final newContact =
          Contact(name: _name, email: _email, phoneNumber: _phoneNumber);
      ScopedModel.of<ContactModel>(context).addContact(newContact);
    }
  }
}
