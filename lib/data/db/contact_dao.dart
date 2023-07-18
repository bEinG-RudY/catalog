import 'package:catalog/data/contact.dart';
import 'package:catalog/data/db/app_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:sembast/sembast.dart';

class ContactDao {
  static const String CONTACT_STORE_NAME = 'contacts';
  // A store with in t keys and Map<String, dynamic> values.
  // This is precisely what we need sincce we convert Contact objects to Map.
  final _contactStore = intMapStoreFactory.store(CONTACT_STORE_NAME);

  Future<Database> get _db async => await AppDatabase.instance.database;

  Future insert(Contact contact) async {
    await _contactStore.add(await _db, contact.toMap());
  }

  Future update(Contact contact) async {
    final finder = Finder(filter: Filter.byKey(contact.id));
    await _contactStore.update(await _db, contact.toMap(), finder: finder);
  }

  Future delete(Contact contact) async {
    final finder = Finder(filter: Filter.byKey(contact.id));
    await _contactStore.delete(await _db, finder: finder);
  }

  Future<List<Contact>> getAllInSortedOrder() async {
    // Finder object canlaso facilitate sorting.
    // As before, we're primarily sorting based on favorite status,
    // secondary sorting is alphabetical
    final finder = Finder(sortOrders: [
      // false indicates that isFavorite will be sorted i descending Order
      // false should be displayed after true for isFavorite.
      SortOrder('isFavorite', false),
      SortOrder('name'),
    ]);

    final RecordSnapshot = await _contactStore.find(await _db, finder: finder);

    // Map iterate over the whole list and gives us acces to every element
    return RecordSnapshot.map((snapshot) {
      final contact = Contact.fromMap(snapshot.value);
      contact.id = snapshot.key;
      return contact;
    }).toList();
  }
}
