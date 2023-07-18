import 'package:catalog/data/contact.dart';
import 'package:catalog/data/db/contact_dao.dart';
import 'package:scoped_model/scoped_model.dart';

class ContactModel extends Model {
  final ContactDao _contactDao = ContactDao();

  // If you don't need to rebuild the widget tree once the model's data changes
  // (when you only make changes to the model, like in the contactCard),
  // you don't need to use scopedModelDescendant with a builder, but only simply
  // call scopedModel.Of<T>() Function;
  late List<Contact>
      _contacts; /*= List.generate(5, (index) {
    return Contact(
        name: faker.person.firstName() + " " + faker.person.lastName(),
        email: faker.internet.freeEmail(),
        phoneNumber: faker.randomGenerator.integer(1000000000).toString());
  });*/

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  List<Contact> get contacts => _contacts;

  Future loadContacts() async {
    _isLoading = true;
    notifyListeners();
    _contacts = await _contactDao.getAllInSortedOrder();
    _isLoading = false;
    notifyListeners();
  }

  Future addContact(Contact contact) async {
    await _contactDao.insert(contact);
    await loadContacts();
    notifyListeners();
  }

  Future updateContact(Contact contact) async {
    await _contactDao.update(contact);
    await loadContacts();
    notifyListeners();
  }

  Future deleteContact(Contact contact) async {
    await _contactDao.delete(contact);
    await loadContacts();
    notifyListeners();
  }

  Future changeFavoriteStatus(Contact contact) async {
    contact.isFavorite = !contact.isFavorite;
    await _contactDao.update(contact);
    // Even though we are loading all contacts, we don't want to change isLoading to true.
    // That's because it woud look silly to display the loading indicator after only
    // hangin the favorite status.
    _contacts = await _contactDao.getAllInSortedOrder();
    notifyListeners();
  }

  // void _sortContacts() {
  //   _contacts.sort(((a, b) {
  //     int comparisonResult;
  //     comparisonResult = _compareBasedonFavoriteStatus(a, b);
  //     if (comparisonResult == 0) {
  //       comparisonResult = _compareAlphabatically(a, b);
  //     }

  //     return comparisonResult;
  //   }));
  // }

  // int _compareBasedonFavoriteStatus(Contact a, Contact b) {
  //   if (a.isFavorite) {
  //     return -1;
  //   } else if (b.isFavorite) {
  //     return 1;
  //   } else {
  //     return 0;
  //   }
  // }

  // int _compareAlphabatically(Contact a, Contact b) {
  //   return a.name.compareTo(b.name);
  // }
}
