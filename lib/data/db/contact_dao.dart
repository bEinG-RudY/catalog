import 'package:catalog/data/contact.dart';
import 'package:catalog/data/db/app_database.dart';
import 'package:sembast/sembast.dart';

class ContactDao {
  static const String CONTACT_STORE_NAME = 'contacts';
  // A store with in t keys and Map<String, dynamic> values.
  // This is precisely what we need sincce we convert Contact objects to Map.
  final _contactStore = intMapStoreFactory.store(CONTACT_STORE_NAME);

  Future insert(Contact contact) async {
    await _contactStore.add(
        await AppDatabase.instance.database, contact.toMap());
  }
}
