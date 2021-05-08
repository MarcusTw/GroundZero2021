import 'dart:async';
import 'dart:io';

import 'package:flutter_app/calendar_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

class DatabaseHelper {
  static DatabaseHelper _databaseHelper;
  static Database _db;

  static int index = 0;
  static String name = "John";
  static DateTime dob = DateTime(1998, 1, 2);
  static String hobbies = "Swimming, Jogging, Dancing";

  static int getAge() {
    return (DateTime.now().difference(dob).inDays / 365).floor();
  }

  DatabaseHelper._createInstance();

  factory DatabaseHelper() {
    if (_databaseHelper == null) {
      _databaseHelper = DatabaseHelper._createInstance();
    }
    return _databaseHelper;
  }

  static int get _version => 1;

  Future<Database> get database async {
    if (_db == null) {
      _db = await init();
    }
    return _db;
  }

  Future<Database> init() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = p.join(directory.path, 'gz.db');
    var gzDatabase = await openDatabase(path, version: _version, onCreate: onCreate);
    return gzDatabase;
  }

  FutureOr<void> onCreate(Database db, int version) async {
    await db.execute(
      'CREATE TABLE events (id INTEGER PRIMARY KEY AUTOINCREMENT, name STRING, date STRING, startTime STRING, endTime STRING, setCounter INTEGER)');
  }

  Future<List<Map<String, dynamic>>> query(String table) async {
    await this.database;
    return await _db.query(table);
  }

  Future<int> insert(String table, CalendarItem item) async {
    await this.database;
    return await _db.insert(table, item.toMap());
  }

  Future<int> delete(String table, CalendarItem item) async {
    await this.database;
    return await _db.delete(table, where: 'id = ?', whereArgs: [item.id]);
  }
}