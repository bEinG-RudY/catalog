import 'package:flutter/material.dart';

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
              decoration: InputDecoration(
                  labelText: "Name",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5))),
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              onSaved: (value) => _phoneNumber = value!,
              decoration: InputDecoration(
                  labelText: "Name",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5))),
            ),
            ElevatedButton(
                onPressed: () {
                  _formKey.currentState?.save();
                  print(_name + " " + _email + " " + _phoneNumber);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [Text("SAVE CONTACT"), Icon(Icons.save)],
                ))
          ],
        ));
  }
}
