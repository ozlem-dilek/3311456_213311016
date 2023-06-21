import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();

  factory DatabaseHelper() => _instance;

  static Database? _database;

  DatabaseHelper._internal();

  Future<Database?> get database async {
    if (_database != null) return _database;

    _database = await _initDatabase();
    return _database;
  }

  Future<Database> _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'countries.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDatabase,
    );
  }

  Future<void> _createDatabase(Database db, int version) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS countries (
        id INTEGER PRIMARY KEY,
        name TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE IF NOT EXISTS universities (
        id INTEGER PRIMARY KEY,
        name TEXT,
        countryId INTEGER,
        FOREIGN KEY (countryId) REFERENCES countries (id)
      )
    ''');

    await db.execute('INSERT INTO countries (name) VALUES ("Turkiye")');

    await db.execute('INSERT INTO universities (name, countryId) VALUES ("Selcuk University", 1)');
    await db.execute('INSERT INTO universities (name, countryId) VALUES ("Konya Technical University", 1)');
    await db.execute('INSERT INTO universities (name, countryId) VALUES ("Necmettin Erbakan University", 1)');
    await db.execute('INSERT INTO universities (name, countryId) VALUES ("Bogazici University", 1)');
    await db.execute('INSERT INTO universities (name, countryId) VALUES ("Middle East Technical University", 1)');
    await db.execute('INSERT INTO universities (name, countryId) VALUES ("Istanbul University", 1)');
    await db.execute('INSERT INTO universities (name, countryId) VALUES ("Ankara University", 1)');
    await db.execute('INSERT INTO universities (name, countryId) VALUES ("Dokuz Eylul University", 1)');
    await db.execute('INSERT INTO universities (name, countryId) VALUES ("KTO Karatay University", 1)');
    await db.execute('INSERT INTO universities (name, countryId) VALUES ("Gazi University", 1)');
    await db.execute('INSERT INTO universities (name, countryId) VALUES ("Akdeniz University", 1)');
    await db.execute('INSERT INTO universities (name, countryId) VALUES ("Samsun University", 1)');
    await db.execute('INSERT INTO universities (name, countryId) VALUES ("Ege University", 1)');
    await db.execute('INSERT INTO universities (name, countryId) VALUES ("Atatürk University", 1)');
    await db.execute('INSERT INTO universities (name, countryId) VALUES ("Karadeniz Technical University", 1)');
  }

  Future<List<Map<String, dynamic>>> getCountries() async {
    Database? db = await database;
    return await db!.query('countries');
  }

  Future<List<Map<String, dynamic>>> getUniversitiesByCountryId(int countryId) async {
    Database? db = await database;
    return await db!.query(
      'universities',
      where: 'countryId = ?',
      whereArgs: [countryId],
    );
  }
}
