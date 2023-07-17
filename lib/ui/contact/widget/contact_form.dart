import 'dart:io';
import 'package:catalog/data/contact.dart';
import 'package:catalog/ui/model/contacts_model.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:scoped_model/scoped_model.dart';

class ContactForm extends StatefulWidget {
  final Contact? editedContact;
  final int? editedContactIndex;

  const ContactForm({
    Key? key,
    this.editedContact,
    this.editedContactIndex,
  }) : super(key: key);

  @override
  State<ContactForm> createState() => _ContactFormState();
}

class _ContactFormState extends State<ContactForm> {
  final _formKey = GlobalKey<FormState>();

  late String _name;
  late String _email;
  late String _phoneNumber;
  File? _contactImageFile;

  bool get isEditMode => widget.editedContact != null;
  bool get hasSelectedCustomImage => _contactImageFile != null;

  @override
  void initState() {
    super.initState();
    _contactImageFile = widget.editedContact?.imageFile;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: ListView(
          children: [
            SizedBox(
              height: 20,
            ),
            _buildContactPicture(),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              onSaved: (value) => _name = value!,
              validator: _validateName,
              initialValue: widget.editedContact?.name,
              decoration: InputDecoration(
                  labelText: "Name",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5))),
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              onSaved: (value) => _email = value!,
              validator: _validateEmail,
              initialValue: widget.editedContact?.email,
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
              initialValue: widget.editedContact?.phoneNumber,
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

  Widget _buildContactPicture() {
    final halfScreenDiameter = MediaQuery.of(context).size.width / 2;
    return Hero(
      // if there no matching tags found in both routes
      // the hero animation will not take place
      tag: widget.editedContact?.hashCode ?? 0,
      child: GestureDetector(
        onTap: _onContactPictureTapped,
        child: CircleAvatar(
          radius: halfScreenDiameter / 2,
          child: _buildCircleAvatarContent(halfScreenDiameter),
        ),
      ),
    );
  }

  void _onContactPictureTapped() async {
    final XFile? imageFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (imageFile != null) {
      setState(() {
        // If there is an imageFilePath, We need to convert it to File
        // otherwise it'll give you an error of "XFile is not subtype of File"
        //or set it to null by default;
        _contactImageFile = File(imageFile.path);
      });
    }
  }

  Widget _buildCircleAvatarContent(double halfScreenDiameter) {
    if (isEditMode || hasSelectedCustomImage) {
      return _buildEditModeCircleAvatarContent(halfScreenDiameter);
    } else {
      return Icon(
        Icons.person,
        size: halfScreenDiameter / 2,
      );
    }
  }

  Widget _buildEditModeCircleAvatarContent(double halfScreenDiameter) {
    if (_contactImageFile == null) {
      return Text(
        widget.editedContact!.name[0],
        style: TextStyle(fontSize: halfScreenDiameter / 2),
      );
    } else {
      // Makes it's child oval to fit "ovalness" of CircleAvatar
      return ClipOval(
        // We Want to transform the image into square and fit the
        // CircleAvatar that's why default aspect ratio is set
        child: AspectRatio(
          aspectRatio: 1,
          child: Image.file(
            _contactImageFile!,
            fit: BoxFit.cover,
          ),
        ),
      );
    }
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
      final newOrEditedContact = Contact(
        name: _name,
        email: _email,
        phoneNumber: _phoneNumber,
        // elvis operator (?.) returns null if editContact is null,
        // Null Coalescing operator(??)
        // If the left side is null, it returns the right side;
        isFavorite: widget.editedContact?.isFavorite ?? false,
        imageFile: _contactImageFile,
      );

      if (isEditMode) {
        newOrEditedContact.id = widget.editedContact!.id;
        ScopedModel.of<ContactModel>(context)
            .updateContact(newOrEditedContact, widget.editedContactIndex!);
      } else {
        ScopedModel.of<ContactModel>(context).addContact(newOrEditedContact);
      }
      Navigator.of(context).pop();
    }
  }
}
