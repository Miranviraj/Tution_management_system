import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/student.dart';
import '../models/Classes.dart';
import '../models/payment.dart';

class DBHelper {
  static final DBHelper instance = DBHelper._init();
  static Database? _database;

  DBHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('school.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE students (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT NOT NULL,
      parentContact TEXT NOT NULL,
      address TEXT NOT NULL,
      attendanceCount INTEGER DEFAULT 0
    )
  ''');

    await db.execute('''
      CREATE TABLE classes (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      date TEXT NOT NULL,
      time TEXT NOT NULL
     
    )
  ''');
    await db.execute('''
      CREATE TABLE classes7 (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      date TEXT NOT NULL,
      time TEXT NOT NULL
     
    )
  ''');await db.execute('''
      CREATE TABLE classes8 (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      date TEXT NOT NULL,
      time TEXT NOT NULL
     
    )
  ''');await db.execute('''
      CREATE TABLE classes9 (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      date TEXT NOT NULL,
      time TEXT NOT NULL
     
    )
  ''');await db.execute('''
      CREATE TABLE classes1 (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      date TEXT NOT NULL,
      time TEXT NOT NULL
     
    )
  ''');await db.execute('''
      CREATE TABLE classes2 (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      date TEXT NOT NULL,
      time TEXT NOT NULL
     
    )
  ''');
    await db.execute('''
    CREATE TABLE attendance (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      studentId INTEGER NOT NULL,
      date TEXT NOT NULL,
      isPresent INTEGER NOT NULL,
      FOREIGN KEY (studentId) REFERENCES students (id) ON DELETE CASCADE
    )
  ''');

    await db.execute('''
    CREATE TABLE payments (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      studentId INTEGER NOT NULL,
      amount REAL NOT NULL,
      date TEXT NOT NULL,
      description TEXT,
      FOREIGN KEY (studentId) REFERENCES students (id) ON DELETE CASCADE
    )
  ''');

    await db.execute('''
      CREATE TABLE students7 (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT NOT NULL,
      parentContact TEXT NOT NULL,
      address TEXT NOT NULL,
      attendanceCount INTEGER DEFAULT 0
    )
  ''');

    await db.execute('''
    CREATE TABLE attendance7 (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      studentId INTEGER NOT NULL,
      date TEXT NOT NULL,
      isPresent INTEGER NOT NULL,
      FOREIGN KEY (studentId) REFERENCES students (id) ON DELETE CASCADE
    )
  ''');

    await db.execute('''
    CREATE TABLE payments7 (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      studentId INTEGER NOT NULL,
      amount REAL NOT NULL,
      date TEXT NOT NULL,
      description TEXT,
      FOREIGN KEY (studentId) REFERENCES students (id) ON DELETE CASCADE
    )
  ''');
    await db.execute('''
      CREATE TABLE students8 (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT NOT NULL,
      parentContact TEXT NOT NULL,
      address TEXT NOT NULL,
      attendanceCount INTEGER DEFAULT 0
    )
  ''');

    await db.execute('''
    CREATE TABLE attendance8 (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      studentId INTEGER NOT NULL,
      date TEXT NOT NULL,
      isPresent INTEGER NOT NULL,
      FOREIGN KEY (studentId) REFERENCES students (id) ON DELETE CASCADE
    )
  ''');

    await db.execute('''
    CREATE TABLE payments8 (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      studentId INTEGER NOT NULL,
      amount REAL NOT NULL,
      date TEXT NOT NULL,
      description TEXT,
      FOREIGN KEY (studentId) REFERENCES students (id) ON DELETE CASCADE
    )
  ''');


    await db.execute('''
      CREATE TABLE students9 (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT NOT NULL,
      parentContact TEXT NOT NULL,
      address TEXT NOT NULL,
      attendanceCount INTEGER DEFAULT 0
    )
  ''');


    await db.execute('''
    CREATE TABLE attendance9 (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      studentId INTEGER NOT NULL,
      date TEXT NOT NULL,
      isPresent INTEGER NOT NULL,
      FOREIGN KEY (studentId) REFERENCES students (id) ON DELETE CASCADE
    )
  ''');

    await db.execute('''
    CREATE TABLE payments9 (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      studentId INTEGER NOT NULL,
      amount REAL NOT NULL,
      date TEXT NOT NULL,
      description TEXT,
      FOREIGN KEY (studentId) REFERENCES students (id) ON DELETE CASCADE
    )
  ''');

    await db.execute('''
      CREATE TABLE students1 (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT NOT NULL,
      parentContact TEXT NOT NULL,
      address TEXT NOT NULL,
      attendanceCount INTEGER DEFAULT 0
    )
  ''');


    await db.execute('''
    CREATE TABLE attendance1 (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      studentId INTEGER NOT NULL,
      date TEXT NOT NULL,
      isPresent INTEGER NOT NULL,
      FOREIGN KEY (studentId) REFERENCES students (id) ON DELETE CASCADE
    )
  ''');

    await db.execute('''
    CREATE TABLE payments1 (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      studentId INTEGER NOT NULL,
      amount REAL NOT NULL,
      date TEXT NOT NULL,
      description TEXT,
      FOREIGN KEY (studentId) REFERENCES students (id) ON DELETE CASCADE
    )
  ''');

    await db.execute('''
      CREATE TABLE students2 (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT NOT NULL,
      parentContact TEXT NOT NULL,
      address TEXT NOT NULL,
      attendanceCount INTEGER DEFAULT 0
    )
  ''');

    await db.execute('''
    CREATE TABLE attendance2 (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      studentId INTEGER NOT NULL,
      date TEXT NOT NULL,
      isPresent INTEGER NOT NULL,
      FOREIGN KEY (studentId) REFERENCES students (id) ON DELETE CASCADE
    )
  ''');

    await db.execute('''
    CREATE TABLE payments2 (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      studentId INTEGER NOT NULL,
      amount REAL NOT NULL,
      date TEXT NOT NULL,
      description TEXT,
      FOREIGN KEY (studentId) REFERENCES students (id) ON DELETE CASCADE
    )
  ''');
  }

  Future<List<Map<String, dynamic>>> getAllStudents() async {
    final db = await database;
    return await db.query('students');
  }

  Future<List<Map<String, dynamic>>> getAllclasses() async {
    final db = await database;
    return await db.query('classes');
  }


  Future<void> incrementStudentAttendance(int studentId) async {
    final db = await database;
    await db.rawUpdate('''
    UPDATE students 
    SET attendanceCount = attendanceCount + 1
    WHERE id = ?
  ''', [studentId]);
  }

  Future<List<Map<String, dynamic>>> getPaymentsByStudent(
      int studentId) async {
    final db = await database;
    return await db.query(
      'payments',
      where: 'studentId = ?',
      whereArgs: [studentId],
    );
  }


  Future<List<Map<String, dynamic>>> fetchPayments() async {
    final db = await database;
    return await db.query('payments');
  }
  Future<int> updatePayment(Map<String, dynamic> payment) async {
    final db = await database;
    return await db.update(
      'payments',
      payment,
      where: 'id = ?',
      whereArgs: [payment['id']],
    );
  }

  Future<int> deletePayment(int id) async {
    final db = await database;
    return await db.delete(
      'payments',
      where: 'id = ?',
      whereArgs: [id],
    );
  }




  Future<void> insertStudent(Student student) async {
    final db = await database;
    await db.insert('students', student.toMap());
  }

  Future<void> insertclass(Classes classes) async {
    final db = await database;
    await db.insert('classes', classes.toMap());
  }

  Future<List<Map<String, dynamic>>> fetchStudents() async {
    final db = await database;
    return await db.query('students');
  }

  Future<List<Map<String, dynamic>>> fetchclasses() async {
    final db = await database;
    return await db.query('classes');
  }

  Future<void> updateclass(Classes classes) async {
    final db = await database;
    await db.update(
      'classes',
      classes.toMap(),
      where: 'id = ?',
      whereArgs: [classes.id],


    );
  }

  Future<void> updateStudent(Student student) async {
    final db = await database;
    await db.update(
      'students',
      student.toMap(),
      where: 'id = ?',
      whereArgs: [student.id],
    );
  }

  Future<int> deleteStudent(int id) async {
    final db = await database;
    return await db.delete(
      'students',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<int> deleteclass(int id) async {
    final db = await database;
    return await db.delete(
      'classes',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> markAttendance(int studentId) async {
    final db = await database;
    final today = DateTime
        .now()
        .toIso8601String()
        .split('T')
        .first;

    // Check if already marked for today to avoid duplicates
    final existing = await db.query(
      'attendance',
      where: 'studentId = ? AND date = ?',
      whereArgs: [studentId, today],
    );

    if (existing.isEmpty) {
      await db.insert('attendance', {
        'studentId': studentId,
        'date': today,
        'status': 'Present', // You can change or customize this field
      });
    }
  }

  Future<int> insertAttendance(Map<String, dynamic> attendance) async {
    final db = await database;
    return await db.insert('attendance', attendance);
  }

  Future<List<Map<String, dynamic>>> fetchAttendance() async {
    final db = await database;
    return await db.query('attendance');
  }

  Future<List<Map<String, dynamic>>> getAttendanceByStudent(
      int studentId) async {
    final db = await database;
    return await db.query(
      'attendance',
      where: 'studentId = ?',
      whereArgs: [studentId],
    );
  }

  Future<int> updateAttendance(Map<String, dynamic> attendance) async {
    final db = await database;
    return await db.update(
      'attendance',
      attendance,
      where: 'id = ?',
      whereArgs: [attendance['id']],
    );
  }

  Future<int> deleteAttendance(int id) async {
    final db = await database;
    return await db.delete(
      'attendance',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> insertPayment(Payment payment) async {
    final db = await database;
    await db.insert(
      'payments', //
      payment.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }


  Future<List<Map<String, dynamic>>> fetchAttendanceByStudentId(int studentId) async {
    final db = await database;
    return db.query('attendance', where: 'studentId = ?', whereArgs: [studentId]);
  }
  // DBHelper.dart

  Future<List<Payment>> fetchPaymentsByStudentId(int studentId) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'payments',
      where: 'studentId = ?',
      whereArgs: [studentId],
    );
    return maps.map((map) => Payment.fromMap(map)).toList();
  }

  Future<int> fetchAttendanceCountByStudentId(int studentId) async {
    final db = await database;
    final result = await db.rawQuery('SELECT COUNT(*) FROM attendance WHERE studentId = ?', [studentId]);
    return Sqflite.firstIntValue(result) ?? 0;
  }
  Future<List<Map<String, dynamic>>> getAllStudents7() async {
    final db = await database;
    return await db.query('students7');
  }

  Future<List<Map<String, dynamic>>> getAllclasses7() async {
    final db = await database;
    return await db.query('classes');
  }


  Future<void> incrementStudentAttendance7(int studentId) async {
    final db = await database;
    await db.rawUpdate('''
    UPDATE students7 
    SET attendanceCount = attendanceCount + 1
    WHERE id = ?
  ''', [studentId]);
  }

  Future<List<Map<String, dynamic>>> getPaymentsByStudent7(
      int studentId) async {
    final db = await database;
    return await db.query(
      'payments7',
      where: 'studentId = ?',
      whereArgs: [studentId],
    );
  }


  Future<List<Map<String, dynamic>>> fetchPayments7() async {
    final db = await database;
    return await db.query('payments7');
  }
  Future<int> updatePayment7(Map<String, dynamic> payment) async {
    final db = await database;
    return await db.update(
      'payments7',
      payment,
      where: 'id = ?',
      whereArgs: [payment['id']],
    );
  }

  Future<int> deletePayment7(int id) async {
    final db = await database;
    return await db.delete(
      'payments7',
      where: 'id = ?',
      whereArgs: [id],
    );
  }




  Future<void> insertStudent7(Student student) async {
    final db = await database;
    await db.insert('students7', student.toMap());
  }

  Future<void> insertclass7(Classes classes) async {
    final db = await database;
    await db.insert('classes7', classes.toMap());
  }

  Future<List<Map<String, dynamic>>> fetchStudents7() async {
    final db = await database;
    return await db.query('students7');
  }

  Future<List<Map<String, dynamic>>> fetchclasses7() async {
    final db = await database;
    return await db.query('classes7');
  }

  Future<void> updateclass7(Classes classes) async {
    final db = await database;
    await db.update(
      'classes7',
      classes.toMap(),
      where:'id=?',
      whereArgs: [classes.id],


    );
  }

  Future<void> updateStudent7(Student student) async {
    final db = await database;
    await db.update(
      'students7',
      student.toMap(),
      where: 'id = ?',
      whereArgs: [student.id],
    );
  }

  Future<int> deleteStudent7(int id) async {
    final db = await database;
    return await db.delete(
      'students',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<int> deleteclass7(int id) async {
    final db = await database;
    return await db.delete(
      'classes7',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> markAttendance7(int studentId) async {
    final db = await database;
    final today = DateTime
        .now()
        .toIso8601String()
        .split('T')
        .first;

    // Check if already marked for today to avoid duplicates
    final existing = await db.query(
      'attendance7',
      where: 'studentId = ? AND date = ?',
      whereArgs: [studentId, today],
    );

    if (existing.isEmpty) {
      await db.insert('attendance7', {
        'studentId': studentId,
        'date': today,
        'status': 'Present', // You can change or customize this field
      });
    }
  }

  Future<int> insertAttendance7(Map<String, dynamic> attendance7) async {
    final db = await database;
    return await db.insert('attendance7', attendance7);
  }

  Future<List<Map<String, dynamic>>> fetchAttendance7() async {
    final db = await database;
    return await db.query('attendance7');
  }

  Future<List<Map<String, dynamic>>> getAttendanceByStudent7(
      int studentId) async {
    final db = await database;
    return await db.query(
      'attendance7',
      where: 'studentId = ?',
      whereArgs: [studentId],
    );
  }

  Future<int> updateAttendance7(Map<String, dynamic> attendance7) async {
    final db = await database;
    return await db.update(
      'attendance7',
      attendance7,
      where: 'id = ?',
      whereArgs: [attendance7['id']],
    );
  }

  Future<int> deleteAttendance7(int id) async {
    final db = await database;
    return await db.delete(
      'attendance7',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> insertPayment7(Payment payment) async {
    final db = await database;
    await db.insert(
      'payments7', //
      payment.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }


  Future<List<Map<String, dynamic>>> fetchAttendanceByStudentId7(int studentId) async {
    final db = await database;
    return db.query('attendance7', where: 'studentId = ?', whereArgs: [studentId]);
  }
  // DBHelper.dart

  Future<List<Payment>> fetchPaymentsByStudentId7(int studentId) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'payments7',
      where: 'studentId = ?',
      whereArgs: [studentId],
    );
    return maps.map((map) => Payment.fromMap(map)).toList();
  }

  Future<int> fetchAttendanceCountByStudentId7(int studentId) async {
    final db = await database;
    final result = await db.rawQuery('SELECT COUNT(*) FROM attendance7 WHERE studentId = ?', [studentId]);
    return Sqflite.firstIntValue(result) ?? 0;
  }

  Future<List<Map<String, dynamic>>> getAllStudents8() async {
    final db = await database;
    return await db.query('students8');
  }

  Future<List<Map<String, dynamic>>> getAllclasses8() async {
    final db = await database;
    return await db.query('classes8');
  }


  Future<void> incrementStudentAttendance8(int studentId) async {
    final db = await database;
    await db.rawUpdate('''
    UPDATE students8 
    SET attendanceCount = attendanceCount + 1
    WHERE id = ?
  ''', [studentId]);
  }

  Future<List<Map<String, dynamic>>> getPaymentsByStudent8(
      int studentId) async {
    final db = await database;
    return await db.query(
      'payments8',
      where: 'studentId = ?',
      whereArgs: [studentId],
    );
  }


  Future<List<Map<String, dynamic>>> fetchPayments8() async {
    final db = await database;
    return await db.query('payments8');
  }
  Future<int> updatePayment8(Map<String, dynamic> payment) async {
    final db = await database;
    return await db.update(
      'payments8',
      payment,
      where: 'id = ?',
      whereArgs: [payment['id']],
    );
  }

  Future<int> deletePayment8(int id) async {
    final db = await database;
    return await db.delete(
      'payments8',
      where: 'id = ?',
      whereArgs: [id],
    );
  }




  Future<void> insertStudent8(Student student) async {
    final db = await database;
    await db.insert('students8', student.toMap());
  }

  Future<void> insertclass8(Classes classes) async {
    final db = await database;
    await db.insert('classes8', classes.toMap());
  }

  Future<List<Map<String, dynamic>>> fetchStudents8() async {
    final db = await database;
    return await db.query('students8');
  }

  Future<List<Map<String, dynamic>>> fetchclasses8() async {
    final db = await database;
    return await db.query('classes8');
  }

  Future<void> updateclass8(Classes classes) async {
    final db = await database;
    await db.update(
      'classes8',
      classes.toMap(),
      where: 'id = ?',
      whereArgs: [classes.id],


    );
  }

  Future<void> updateStudent8(Student student) async {
    final db = await database;
    await db.update(
      'students8',
      student.toMap(),
      where: 'id = ?',
      whereArgs: [student.id],
    );
  }

  Future<int> deleteStudent8(int id) async {
    final db = await database;
    return await db.delete(
      'students8',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<int> deleteclass8(int id) async {
    final db = await database;
    return await db.delete(
      'classes8',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> markAttendance8(int studentId) async {
    final db = await database;
    final today = DateTime
        .now()
        .toIso8601String()
        .split('T')
        .first;

    // Check if already marked for today to avoid duplicates
    final existing = await db.query(
      'attendance8',
      where: 'studentId = ? AND date = ?',
      whereArgs: [studentId, today],
    );

    if (existing.isEmpty) {
      await db.insert('attendance8', {
        'studentId': studentId,
        'date': today,
        'status': 'Present', // You can change or customize this field
      });
    }
  }

  Future<int> insertAttendance8(Map<String, dynamic> attendance) async {
    final db = await database;
    return await db.insert('attendance8', attendance);
  }

  Future<List<Map<String, dynamic>>> fetchAttendance8() async {
    final db = await database;
    return await db.query('attendance8');
  }

  Future<List<Map<String, dynamic>>> getAttendanceByStudent8(
      int studentId) async {
    final db = await database;
    return await db.query(
      'attendance8',
      where: 'studentId = ?',
      whereArgs: [studentId],
    );
  }

  Future<int> updateAttendance8(Map<String, dynamic> attendance) async {
    final db = await database;
    return await db.update(
      'attendance8',
      attendance,
      where: 'id = ?',
      whereArgs: [attendance['id']],
    );
  }

  Future<int> deleteAttendance8(int id) async {
    final db = await database;
    return await db.delete(
      'attendance8',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> insertPayment8(Payment payment) async {
    final db = await database;
    await db.insert(
      'payments8', //
      payment.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }


  Future<List<Map<String, dynamic>>> fetchAttendanceByStudentId8(int studentId) async {
    final db = await database;
    return db.query('attendance8', where: 'studentId = ?', whereArgs: [studentId]);
  }
  // DBHelper.dart

  Future<List<Payment>> fetchPaymentsByStudentId8(int studentId) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'payments8',
      where: 'studentId = ?',
      whereArgs: [studentId],
    );
    return maps.map((map) => Payment.fromMap(map)).toList();
  }

  Future<int> fetchAttendanceCountByStudentId8(int studentId) async {
    final db = await database;
    final result = await db.rawQuery('SELECT COUNT(*) FROM attendance8 WHERE studentId = ?', [studentId]);
    return Sqflite.firstIntValue(result) ?? 0;
  }

  Future<List<Map<String, dynamic>>> getAllStudents9() async {
    final db = await database;
    return await db.query('students9');
  }

  Future<List<Map<String, dynamic>>> getAllclasses9() async {
    final db = await database;
    return await db.query('classes9');
  }


  Future<void> incrementStudentAttendance9(int studentId) async {
    final db = await database;
    await db.rawUpdate('''
    UPDATE students9 
    SET attendanceCount = attendanceCount + 1
    WHERE id = ?
  ''', [studentId]);
  }

  Future<List<Map<String, dynamic>>> getPaymentsByStudent9(
      int studentId) async {
    final db = await database;
    return await db.query(
      'payments9',
      where: 'studentId = ?',
      whereArgs: [studentId],
    );
  }


  Future<List<Map<String, dynamic>>> fetchPayments9() async {
    final db = await database;
    return await db.query('payments9');
  }
  Future<int> updatePayment9(Map<String, dynamic> payment) async {
    final db = await database;
    return await db.update(
      'payments9',
      payment,
      where: 'id = ?',
      whereArgs: [payment['id']],
    );
  }

  Future<int> deletePayment9(int id) async {
    final db = await database;
    return await db.delete(
      'payments9',
      where: 'id = ?',
      whereArgs: [id],
    );
  }




  Future<void> insertStudent9(Student student) async {
    final db = await database;
    await db.insert('students9', student.toMap());
  }

  Future<void> insertclass9(Classes classes) async {
    final db = await database;
    await db.insert('classes9', classes.toMap());
  }

  Future<List<Map<String, dynamic>>> fetchStudents9() async {
    final db = await database;
    return await db.query('students9');
  }

  Future<List<Map<String, dynamic>>> fetchclasses9() async {
    final db = await database;
    return await db.query('classes9');
  }

  Future<void> updateclass9(Classes classes) async {
    final db = await database;
    await db.update(
      'classes9',
      classes.toMap(),
      where:'id=?',
      whereArgs: [classes.id],


    );
  }

  Future<void> updateStudent9(Student student) async {
    final db = await database;
    await db.update(
      'students9',
      student.toMap(),
      where: 'id = ?',
      whereArgs: [student.id],
    );
  }

  Future<int> deleteStudent9(int id) async {
    final db = await database;
    return await db.delete(
      'students9',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<int> deleteclass9(int id) async {
    final db = await database;
    return await db.delete(
      'classes9',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> markAttendance9(int studentId) async {
    final db = await database;
    final today = DateTime
        .now()
        .toIso8601String()
        .split('T')
        .first;

    // Check if already marked for today to avoid duplicates
    final existing = await db.query(
      'attendance9',
      where: 'studentId = ? AND date = ?',
      whereArgs: [studentId, today],
    );

    if (existing.isEmpty) {
      await db.insert('attendance9', {
        'studentId': studentId,
        'date': today,
        'status': 'Present', // You can change or customize this field
      });
    }
  }

  Future<int> insertAttendance9(Map<String, dynamic> attendance) async {
    final db = await database;
    return await db.insert('attendance9', attendance);
  }

  Future<List<Map<String, dynamic>>> fetchAttendance9() async {
    final db = await database;
    return await db.query('attendance9');
  }

  Future<List<Map<String, dynamic>>> getAttendanceByStudent9(
      int studentId) async {
    final db = await database;
    return await db.query(
      'attendance9',
      where: 'studentId = ?',
      whereArgs: [studentId],
    );
  }

  Future<int> updateAttendance9(Map<String, dynamic> attendance) async {
    final db = await database;
    return await db.update(
      'attendance9',
      attendance,
      where: 'id = ?',
      whereArgs: [attendance['id']],
    );
  }

  Future<int> deleteAttendance9(int id) async {
    final db = await database;
    return await db.delete(
      'attendance9',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> insertPayment9(Payment payment) async {
    final db = await database;
    await db.insert(
      'payments9', //
      payment.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }


  Future<List<Map<String, dynamic>>> fetchAttendanceByStudentId9(int studentId) async {
    final db = await database;
    return db.query('attendance9', where: 'studentId = ?', whereArgs: [studentId]);
  }
  // DBHelper.dart

  Future<List<Payment>> fetchPaymentsByStudentId9(int studentId) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'payments9',
      where: 'studentId = ?',
      whereArgs: [studentId],
    );
    return maps.map((map) => Payment.fromMap(map)).toList();
  }

  Future<int> fetchAttendanceCountByStudentId9(int studentId) async {
    final db = await database;
    final result = await db.rawQuery('SELECT COUNT(*) FROM attendance9 WHERE studentId = ?', [studentId]);
    return Sqflite.firstIntValue(result) ?? 0;
  }

  Future<List<Map<String, dynamic>>> getAllStudents1() async {
    final db = await database;
    return await db.query('students1');
  }

  Future<List<Map<String, dynamic>>> getAllclasses1() async {
    final db = await database;
    return await db.query('classes1');
  }


  Future<void> incrementStudentAttendance1(int studentId) async {
    final db = await database;
    await db.rawUpdate('''
    UPDATE students1 
    SET attendanceCount = attendanceCount + 1
    WHERE id = ?
  ''', [studentId]);
  }

  Future<List<Map<String, dynamic>>> getPaymentsByStudent1(
      int studentId) async {
    final db = await database;
    return await db.query(
      'payments1',
      where: 'studentId = ?',
      whereArgs: [studentId],
    );
  }


  Future<List<Map<String, dynamic>>> fetchPayments1() async {
    final db = await database;
    return await db.query('payments1');
  }
  Future<int> updatePayment1(Map<String, dynamic> payment) async {
    final db = await database;
    return await db.update(
      'payments1',
      payment,
      where: 'id = ?',
      whereArgs: [payment['id']],
    );
  }

  Future<int> deletePayment1(int id) async {
    final db = await database;
    return await db.delete(
      'payments1',
      where: 'id = ?',
      whereArgs: [id],
    );
  }




  Future<void> insertStudent1(Student student) async {
    final db = await database;
    await db.insert('students1', student.toMap());
  }

  Future<void> insertclass1(Classes classes) async {
    final db = await database;
    await db.insert('classes1', classes.toMap());
  }

  Future<List<Map<String, dynamic>>> fetchStudents1() async {
    final db = await database;
    return await db.query('students1');
  }

  Future<List<Map<String, dynamic>>> fetchclasses1() async {
    final db = await database;
    return await db.query('classes1');
  }

  Future<void> updateclass1(Classes classes) async {
    final db = await database;
    await db.update(
      'classes1',
      classes.toMap(),
      where:'id=?',
      whereArgs: [classes.id],


    );
  }

  Future<void> updateStudent1(Student student) async {
    final db = await database;
    await db.update(
      'students1',
      student.toMap(),
      where: 'id = ?',
      whereArgs: [student.id],
    );
  }

  Future<int> deleteStudent1(int id) async {
    final db = await database;
    return await db.delete(
      'students1',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<int> deleteclass1(int id) async {
    final db = await database;
    return await db.delete(
      'classes1',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> markAttendance1(int studentId) async {
    final db = await database;
    final today = DateTime
        .now()
        .toIso8601String()
        .split('T')
        .first;

    // Check if already marked for today to avoid duplicates
    final existing = await db.query(
      'attendance1',
      where: 'studentId = ? AND date = ?',
      whereArgs: [studentId, today],
    );

    if (existing.isEmpty) {
      await db.insert('attendance1', {
        'studentId': studentId,
        'date': today,
        'status': 'Present', // You can change or customize this field
      });
    }
  }

  Future<int> insertAttendance1(Map<String, dynamic> attendance) async {
    final db = await database;
    return await db.insert('attendance1', attendance);
  }

  Future<List<Map<String, dynamic>>> fetchAttendance1() async {
    final db = await database;
    return await db.query('attendance1');
  }

  Future<List<Map<String, dynamic>>> getAttendanceByStudent1(
      int studentId) async {
    final db = await database;
    return await db.query(
      'attendance1',
      where: 'studentId = ?',
      whereArgs: [studentId],
    );
  }

  Future<int> updateAttendance1(Map<String, dynamic> attendance) async {
    final db = await database;
    return await db.update(
      'attendance1',
      attendance,
      where: 'id = ?',
      whereArgs: [attendance['id']],
    );
  }

  Future<int> deleteAttendance1(int id) async {
    final db = await database;
    return await db.delete(
      'attendance1',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> insertPayment1(Payment payment) async {
    final db = await database;
    await db.insert(
      'payments1', //
      payment.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }


  Future<List<Map<String, dynamic>>> fetchAttendanceByStudentId1(int studentId) async {
    final db = await database;
    return db.query('attendance', where: 'studentId = ?', whereArgs: [studentId]);
  }
  // DBHelper.dart

  Future<List<Payment>> fetchPaymentsByStudentId1(int studentId) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'payments',
      where: 'studentId = ?',
      whereArgs: [studentId],
    );
    return maps.map((map) => Payment.fromMap(map)).toList();
  }

  Future<int> fetchAttendanceCountByStudentId1(int studentId) async {
    final db = await database;
    final result = await db.rawQuery('SELECT COUNT(*) FROM attendance1 WHERE studentId = ?', [studentId]);
    return Sqflite.firstIntValue(result) ?? 0;
  }

  Future<List<Map<String, dynamic>>> getAllStudents2() async {
    final db = await database;
    return await db.query('students2');
  }

  Future<List<Map<String, dynamic>>> getAllclasses2() async {
    final db = await database;
    return await db.query('classes2');
  }


  Future<void> incrementStudentAttendance2(int studentId) async {
    final db = await database;
    await db.rawUpdate('''
    UPDATE students2 
    SET attendanceCount = attendanceCount + 1
    WHERE id = ?
  ''', [studentId]);
  }

  Future<List<Map<String, dynamic>>> getPaymentsByStudent2(
      int studentId) async {
    final db = await database;
    return await db.query(
      'payments2',
      where: 'studentId = ?',
      whereArgs: [studentId],
    );
  }


  Future<List<Map<String, dynamic>>> fetchPayments2() async {
    final db = await database;
    return await db.query('payments2');
  }
  Future<int> updatePayment2(Map<String, dynamic> payment) async {
    final db = await database;
    return await db.update(
      'payments2',
      payment,
      where: 'id = ?',
      whereArgs: [payment['id']],
    );
  }

  Future<int> deletePayment2(int id) async {
    final db = await database;
    return await db.delete(
      'payments2',
      where: 'id = ?',
      whereArgs: [id],
    );
  }




  Future<void> insertStudent2(Student student) async {
    final db = await database;
    await db.insert('students2', student.toMap());
  }

  Future<void> insertclass2(Classes classes) async {
    final db = await database;
    await db.insert('classes2', classes.toMap());
  }

  Future<List<Map<String, dynamic>>> fetchStudents2() async {
    final db = await database;
    return await db.query('students2');
  }

  Future<List<Map<String, dynamic>>> fetchclasses2() async {
    final db = await database;
    return await db.query('classes2');
  }

  Future<void> updateclass2(Classes classes) async {
    final db = await database;
    await db.update(
      'classes2',
      classes.toMap(),
      where:'id=?',
      whereArgs: [classes.id],


    );
  }
  Future<List<Map<String, dynamic>>> getAttendanceWithStudents() async {
    final db = await instance.database;
    return await db.rawQuery('''
    SELECT a.date, s.id, s.name
    FROM attendance a
    INNER JOIN students s ON a.studentId = s.id
    WHERE a.isPresent = 1
    ORDER BY a.date DESC
  ''');
  }


  Future<List<Map<String, dynamic>>> getAttendanceWithStudents7() async {
    final db = await instance.database;
    return await db.rawQuery('''
    SELECT a.date, s.id, s.name
    FROM attendance7 a
    INNER JOIN students7 s ON a.studentId = s.id
    WHERE a.isPresent = 1
    ORDER BY a.date DESC
  ''');
  }

  Future<List<Map<String, dynamic>>> getAttendanceWithStudents8() async {
    final db = await instance.database;
    return await db.rawQuery('''
    SELECT a.date, s.id, s.name
    FROM attendance8 a
    INNER JOIN students8 s ON a.studentId = s.id
    WHERE a.isPresent = 1
    ORDER BY a.date DESC
  ''');
  }

  Future<List<Map<String, dynamic>>> getAttendanceWithStudents9() async {
    final db = await instance.database;
    return await db.rawQuery('''
    SELECT a.date, s.id, s.name
    FROM attendance9 a
    INNER JOIN students9 s ON a.studentId = s.id
    WHERE a.isPresent = 1
    ORDER BY a.date DESC
  ''');
  }

  Future<List<Map<String, dynamic>>> getAttendanceWithStudents1() async {
    final db = await instance.database;
    return await db.rawQuery('''
    SELECT a.date, s.id, s.name
    FROM attendance1 a
    INNER JOIN students1 s ON a.studentId = s.id
    WHERE a.isPresent = 1
    ORDER BY a.date DESC
  ''');
  }
  Future<List<Map<String, dynamic>>> getAttendanceWithStudents2() async {
    final db = await instance.database;
    return await db.rawQuery('''
    SELECT a.date, s.id, s.name
    FROM attendance2 a
    INNER JOIN students2 s ON a.studentId = s.id
    WHERE a.isPresent = 1
    ORDER BY a.date DESC
  ''');
  }
  Future<void> updateStudent2(Student student) async {
    final db = await database;
    await db.update(
      'students2',
      student.toMap(),
      where: 'id = ?',
      whereArgs: [student.id],
    );
  }

  Future<int> deleteStudent2(int id) async {
    final db = await database;
    return await db.delete(
      'students2',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<int> deleteclass2(int id) async {
    final db = await database;
    return await db.delete(
      'classes2',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> markAttendance2(int studentId) async {
    final db = await database;
    final today = DateTime
        .now()
        .toIso8601String()
        .split('T')
        .first;

    // Check if already marked for today to avoid duplicates
    final existing = await db.query(
      'attendance2',
      where: 'studentId = ? AND date = ?',
      whereArgs: [studentId, today],
    );

    if (existing.isEmpty) {
      await db.insert('attendance2', {
        'studentId': studentId,
        'date': today,
        'status': 'Present', // You can change or customize this field
      });
    }
  }

  Future<int> insertAttendance2(Map<String, dynamic> attendance) async {
    final db = await database;
    return await db.insert('attendance2', attendance);
  }

  Future<List<Map<String, dynamic>>> fetchAttendance2() async {
    final db = await database;
    return await db.query('attendance2');
  }

  Future<List<Map<String, dynamic>>> getAttendanceByStudent2(
      int studentId) async {
    final db = await database;
    return await db.query(
      'attendance2',
      where: 'studentId = ?',
      whereArgs: [studentId],
    );
  }

  Future<int> updateAttendance2(Map<String, dynamic> attendance) async {
    final db = await database;
    return await db.update(
      'attendance2',
      attendance,
      where: 'id = ?',
      whereArgs: [attendance['id']],
    );
  }

  Future<int> deleteAttendance2(int id) async {
    final db = await database;
    return await db.delete(
      'attendance',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> insertPayment2(Payment payment) async {
    final db = await database;
    await db.insert(
      'payments2', //
      payment.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }


  Future<List<Map<String, dynamic>>> fetchAttendanceByStudentId2(int studentId) async {
    final db = await database;
    return db.query('attendance2', where: 'studentId = ?', whereArgs: [studentId]);
  }
  // DBHelper.dart

  Future<List<Payment>> fetchPaymentsByStudentId2(int studentId) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'payments2',
      where: 'studentId = ?',
      whereArgs: [studentId],
    );
    return maps.map((map) => Payment.fromMap(map)).toList();
  }

  Future<int> fetchAttendanceCountByStudentId2(int studentId) async {
    final db = await database;
    final result = await db.rawQuery('SELECT COUNT(*) FROM attendance2 WHERE studentId = ?', [studentId]);
    return Sqflite.firstIntValue(result) ?? 0;
  }






}
