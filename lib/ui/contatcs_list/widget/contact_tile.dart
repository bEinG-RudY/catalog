import 'package:catalog/ui/contact/Contact_edit_page.dart';
import 'package:catalog/ui/model/contacts_model.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../../data/contact.dart';

class ContactTile extends StatelessWidget {
  const ContactTile({
    Key? key,
    required this.contactIndex,
  }) : super(key: key);
  final int contactIndex;

  @override
  Widget build(BuildContext context) {
    // If you don't need to rebuild the widget tree once the model's data changes
    // (when you only make changes to the model, like in the contactCard),
    // you don't need to use scopedModelDescendant with a builder, but only simply
    // call scopedModel.Of<T>() Function;
    final model = ScopedModel.of<ContactModel>(context);
    final displayContact = model.contacts[contactIndex];
    return ListTile(
        title: Text(displayContact.name),
        subtitle: Text(displayContact.email),
        trailing: IconButton(
          icon: Icon(displayContact.isFavorite ? Icons.star : Icons.star_border,
              color: displayContact.isFavorite ? Colors.amber : Colors.grey),
          onPressed: () {
            model.changeFavoriteStatus(contactIndex);
          },
        ),
        onTap: () => Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => ContactEditPage(
                editedContact: displayContact,
                editedContactIndex: contactIndex))));
  }
}
