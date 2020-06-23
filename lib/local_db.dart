import 'dart:io';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:async';


class EmailAddress {
  final int id;
  final String value;

  EmailAddress({this.id, this.value});

  // Convert an EmailAddress object into a Map. The keys must correspond to the names of the
  // columns in the database.
  Map<String, dynamic> toMapForDb() {
    return {
      'id' : id,
      'value' : value,
    };
  }
  // it is necessary to create a constructor, which takes the Map<String, dynamic> as
  // input parameters
  EmailAddress.fromDb(Map<String, dynamic> map)
      : id = map['id'],
        value = map['value'];

  @override
  toString() {return "${this.id}: " + this.value;}
}

// Helper, also implementing singleton pattern
class DBHelper {
  static final DBHelper _instance = DBHelper._();
  static Database _database;

  DBHelper._();

  factory DBHelper() {
    return _instance;
  }

  Future<Database> get db async {
    if (_database != null) {
      return _database;
    }

    _database = await init();

    return _database;
  }

  Future<Database> init() async {
    print("Future<Database> init()");
    Directory directory = await
    getApplicationDocumentsDirectory();
    String dbPath = join(directory.path, 'emails.db');
    var database = openDatabase(dbPath, version: 1, onCreate: _onCreate, onUpgrade: _onUpgrade);
    print("db opened");
    return database;
  }

  // create table
  void _onCreate(Database db, int version) {
    db.execute('''
      CREATE TABLE emails(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        value TEXT)
    ''');
    print("table created!");
  }

  // If the database has already been created before and it is necessary to
  // roll out the migrations
  void _onUpgrade(Database db, int oldVersion, int newVersion) {
    // Run migration according database versions
    print("onUpgrade");
  }

  Future<int> addEmailAddress(EmailAddress emailAddress) async {
    print("add email address");
    var client = await db;
    return client.insert('emails', emailAddress.toMapForDb(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<EmailAddress> fetchEmailAddress(int id) async {
    print("fetch email address by id:$id");
    var client = await db;
    final Future<List<Map<String, dynamic>>> futureMaps = client.query('emails', where: 'id = ?', whereArgs: [id]);
    var maps = await futureMaps;
    if (maps.length != 0) {
      return EmailAddress.fromDb(maps.first);
    }
    return null;
  }

  Future<int> updateEmailAddress(EmailAddress newEmailAddress) async {
    print("update email address");
    var client = await db;
    return client.update('emails', newEmailAddress.toMapForDb(), where: 'id = ?', whereArgs: [newEmailAddress.id], conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> removeEmailAddress(String mail) async {
    print("remove email address");
    var client = await db;
    return client.delete('emails', where: 'value = ?', whereArgs: [mail]);
  }
  Future<void> selectEmail(EmailAddress Email) async {
    print("select email address");
    var client = await db;
    return client.execute("SELECT value WHERE value = $Email");
  }
  // A method that retrieves all the addresses from the EmailAddress table.
  Future<List<EmailAddress>> emails() async {
    print("List all email addresses");
    // Get a reference to the database.
    final client = await db;

    // Query the table for all The Dogs.
    final List<Map<String, dynamic>> maps = await client.query('emails');

    // Convert the List<Map<String, dynamic> into a List<Dog>.
    return List.generate(maps.length, (i) {
      return EmailAddress(
        id: maps[i]['id'],
        value: maps[i]['value'],
      );
    });
  }

}