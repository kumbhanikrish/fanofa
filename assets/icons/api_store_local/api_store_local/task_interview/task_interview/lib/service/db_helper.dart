import 'dart:developer';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:task_interview/service/model/student_list_model.dart';

class DBHelper {
  static final DBHelper _instance = DBHelper._internal();
  factory DBHelper() => _instance;
  DBHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'students.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE students (
            bp_tal_id TEXT PRIMARY KEY,
            bp_fname TEXT,
            bp_id TEXT,
            bp_mname TEXT,
            bp_lname TEXT,
            bp_mobile_no TEXT,
            bk_profile TEXT,
            bp_gender TEXT,
            bp_email TEXT
          )
        ''');
      },
    );
  }

  Future insertStudent(Map<String, dynamic> student) async {
    final db = await database;
    await db.insert(
      'students',
      student,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future updateUserProfile({required Map<String, dynamic> data}) async {
    final db = await database;

    log('updatedValuesupdatedValues ::${data}');

    await db.update(
      'students',
      data,
      where: 'bp_id = ?',
      whereArgs: [data['bp_id']],
    );
  }

  Future<List<Map<String, dynamic>>> fetchStudents() async {
    final db = await database;
    return await db.query('students');
  }
}
