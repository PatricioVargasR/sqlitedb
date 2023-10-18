import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:async';
import 'package:path_provider/path_provider.dart';
import 'dart:io' as io;

class DBManager {
  static Database? _db;
  static const String ID = 'controlNum';
  static const String NAME = 'name';
  static const String APEPA = 'apepa';
  static const String APEMA = 'apema';
  static const String TEL = 'tel';
  static const String EMAIL = 'email';
  static const String PHOTO_NAME = 'photo_name';
  static const String TABLE = 'Students';
  static const String DB_NAME = 'students.db';

  //InitDB
  Future<Database?> get db async {
    if (_db != null) {
      return _db;
    } else {
      _db = await initDB();
      return _db;
    }
  }

  initDB() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, DB_NAME);
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  _onCreate(Database db, int version) async {
    await db.execute(
        "CREATE TABLE $TABLE ($ID INTEGER PRIMARY KEY, "
            "$NAME TEXT, $APEPA TEXT, $APEMA TEXT, $TEL TEXT, "
            "$EMAIL TEXT, $PHOTO_NAME TEXT)");
  }
  // Create
  Future<int> insertStudent(Map<String, dynamic> student) async {
    Database? database = await db;
    return await database!.insert(TABLE, student);
  }

  // Read
  Future<List<Map<String, dynamic>>> getStudents() async {
    Database? database = await db;
    return await database!.query(TABLE);
  }

  // Update
  Future<int> updateStudent(Map<String, dynamic> student) async {
    Database? database = await db;
    return await database!.update(
      TABLE,
      student,
      where: '$ID = ?',
      whereArgs: [student[ID]],
    );
  }

  // Delete
  Future<int> deleteStudent(int studentID) async {
    Database? database = await db;
    return await database!
        .delete(TABLE, where: '$ID = ?', whereArgs: [studentID]);
  }
}

