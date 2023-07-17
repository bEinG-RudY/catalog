import 'dart:async';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';
import 'package:path/path.dart';

class AppDatabase {
  // The only available instance of this AppDatabase Class
  // is stored in this private field _singleton
  static final AppDatabase _singleton = AppDatabase._();

  static AppDatabase get instance => _singleton;

  // Completer is used for transforming synchronous(code which runs line by line) code into asynchronous code.
  Completer<Database>? _dbOpenCompleter;

  // This is a private constructor
  // To make a Constructor private we have to do like this "AppDatabase._()"
  // If a class specifies its own constructor, it immediately lossed the default one.
  // This means that by providing a private constructor, we can create new instances
  // only from within this AppDatabase class itself.
  AppDatabase._();

  Future<Database> get database async {
    // If completer is null, database is not yet opened
    if (_dbOpenCompleter == null) {
      _dbOpenCompleter = Completer();
      // Calling _openDatabase will also conplete the completer with database instance
      _openDatabase();
    }
    // If the database is alredy opened, return immediately.
    // Otherwise, wait until complete() is called on the Completer in _opernDatabase
    return _dbOpenCompleter!.future;
  }

  Future _openDatabase() async {
    // Get a platform-specific directory like android or ios where persistent app data can be stored
    final appDocumentDir = await getApplicationDocumentsDirectory();
    // This line generate path with the form: /plateform-specific-directory/contacts.db
    final dbPath = join(appDocumentDir.path, 'contacts.db');
    final database = await databaseFactoryIo.openDatabase(dbPath);
    _dbOpenCompleter!.complete(database);
  }
}
