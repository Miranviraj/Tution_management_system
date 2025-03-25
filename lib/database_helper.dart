import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';


class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  static Database? _database;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'students.db');
    print('Database path: $path'); // Print the database path
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE students(id INTEGER PRIMARY KEY, name TEXT, phone TEXT, address TEXT)',
        );
      },
    );
  }

  Future<List<Map<String, dynamic>>> getStudents() async {
    final db = await database;
    return await db.query('students');
  }

  Future<void> insertStudent(Map<String, String> student) async {
    final db = await database;
    await db.insert(
      'students',
      {
        'name': student['name']!,
        'phone': student['phone']!,
        'address': student['address']!,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
}