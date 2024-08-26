import 'dart:async';
import 'dart:typed_data';
import 'package:agenda_app/src/domain/entities/user.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static DatabaseHelper? _instance;
  static Database? _database;

  DatabaseHelper._internal();

  factory DatabaseHelper() {
    _instance ??= DatabaseHelper._internal();
    return _instance!;
  }

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async {
    String path = join(await getDatabasesPath(), 'agenda.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE user(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        firstName TEXT,
        lastName TEXT,
        email TEXT,
        gender TEXT,
        dateOfBirth TEXT,
        imagePath BLOB
      )
    ''');

    // Create the 'agenda' table
    await db.execute('''
      CREATE TABLE agenda (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT,
        description TEXT,
        date TEXT,
        userId INTEGER,
        FOREIGN KEY (userId) REFERENCES user (id)
      )
    ''');
  }

  Future<int> insertUser(User user) async {
    Database db = await database;
    return await db.insert('user', {
      'firstName': user.firstName,
      'lastName': user.lastName,
      'dateOfBirth': user.dateOfBirth,
      'gender': user.gender,
      'email': user.email,
      'imagePath': user.imagePath,
    });
  }

  Future<int> updateUser(User user) async {
    Database db = await database;
    return await db.update(
      'user',
      {
        'firstName': user.firstName,
        'lastName': user.lastName,
        'dateOfBirth': user.dateOfBirth,
        'gender': user.gender,
        'email': user.email,
        'imagePath': Uint8List.fromList(user.imagePath ?? []),
      },
      where: 'id = ?',
      whereArgs: [user.id],
    );
  }

  Future<List<Map<String, dynamic>>> getUsers() async {
    Database db = await database;
    return await db.query('user');
  }
}
