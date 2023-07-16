import 'package:catalog/ui/contact/Contact_edit_page.dart';
import 'package:catalog/ui/model/contacts_model.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

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
    return Slidable(
      endActionPane: ActionPane(motion: BehindMotion(), children: [
        SlidableAction(
          flex: 1,
          onPressed: (context) {
            model.deleteContact(contactIndex);
          },
          backgroundColor: Colors.red,
          foregroundColor: Colors.white,
          icon: Icons.delete,
          label: 'Delete',
        ),
      ]),
      child: _buildContent(displayContact, model, context),
    );
  }

  ListTile _buildContent(
      Contact displayContact, ContactModel model, BuildContext context) {
    return ListTile(
        title: Text(displayContact.name),
        subtitle: Text(displayContact.email),
        leading: _buildCircleAvatar(displayContact),
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

  Hero _buildCircleAvatar(Contact displayContact) =>
      // Hero widget facilitates a hero animation between routes(pages) in a simple way.
      // It's important that the tag is the SAME and UNIQUE in both routes;
      Hero(
          // hashcode return a fairly unique integer based on
          // the content of the displayContact object;
          tag: displayContact.hashCode,
          child:
              CircleAvatar(child: _buildCircleAvatarContent(displayContact)));

  Widget _buildCircleAvatarContent(Contact displayContact) {
    if (displayContact.imageFile == null) {
      return Text(displayContact.name[0]);
    } else {
      return ClipOval(
        child: AspectRatio(
          aspectRatio: 1,
          child: Image.file(
            displayContact.imageFile!,
            fit: BoxFit.cover,
          ),
        ),
      );
    }
  }
}
