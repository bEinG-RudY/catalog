import 'package:catalog/data/contact.dart';
import 'package:faker/faker.dart';
import 'package:scoped_model/scoped_model.dart';

class ContactModel extends Model {
  // If you don't need to rebuild the widget tree once the model's data changes
  // (when you only make changes to the model, like in the contactCard),
  // you don't need to use scopedModelDescendant with a builder, but only simply
  // call scopedModel.Of<T>() Function;
  late List<Contact> _contacts = List.generate(50, (index) {
    return Contact(
        name: faker.person.firstName() + " " + faker.person.lastName(),
        email: faker.internet.freeEmail(),
        phoneNumber: faker.randomGenerator.integer(1000000000).toString());
  });

  List<Contact> get contacts => _contacts;

  void addContact(Contact contact) {
    _contacts.add(contact);
    notifyListeners();
  }

  void changeFavoriteStatus(int index) {
    print(_contacts.length);
    _contacts[index].isFavorite = !_contacts[index].isFavorite;
    print(_contacts.length);
    _sortContacts();
    notifyListeners();
  }

  void _sortContacts() {
    _contacts.sort(((a, b) {
      int comparisonResult;
      comparisonResult = _compareBasedonFavoriteStatus(a, b);
      if (comparisonResult == 0) {
        comparisonResult = _compareAlphabatically(a, b);
      }

      return comparisonResult;
    }));
  }

  int _compareBasedonFavoriteStatus(Contact a, Contact b) {
    if (a.isFavorite) {
      return -1;
    } else if (b.isFavorite) {
      return 1;
    } else {
      return 0;
    }
  }

  int _compareAlphabatically(Contact a, Contact b) {
    return a.name.compareTo(b.name);
  }
}
