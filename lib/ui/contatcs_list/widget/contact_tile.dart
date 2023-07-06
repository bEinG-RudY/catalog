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
    );
  }
}
