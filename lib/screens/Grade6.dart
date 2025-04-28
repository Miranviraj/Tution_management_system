import 'package:flutter/material.dart';
import '../db/db_helper.dart';
import '../models/Classes.dart';
import '../models/student.dart';
import '../models/attendance.dart';
import '../models/payment.dart';
import 'student_details_screen.dart';
import 'package:untitled11/main.dart';
import 'package:telephony/telephony.dart';
import 'package:fluttertoast/fluttertoast.dart';




void main() async {
  // Ensures Flutter bindings are initialized
  WidgetsFlutterBinding.ensureInitialized();


}

class Grade6 extends StatelessWidget {
  const Grade6({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0XFF123524),
        title: Center(
          child: Text(
            "Tuition Management System",
            style: TextStyle(
              color: Color(0xFFEFE3C2),
              fontSize: 15.0,
              fontWeight: FontWeight.bold,
              fontFamily: 'Krona One',
            ),
          ),
        ),
      ),
      body: Row(
        children: [
          // Sidebar
          Container(
            width: 150,
            color:  Color(0xff85A947),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _sidebarButton(context, "Home"),
                _sidebarButton(context, "Students"),
                _sidebarButton(context, "Classes"),
                _sidebarButton(context, "Attendance"),
                _sidebarButton(context, "Payment"),
                _sidebarButton(context, "Attendance Report"),
                SizedBox(height: 20),
                IconButton(
                  icon: Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => MyApp()),
                    );
                  },
                )
              ],
            ),
          ),
          // Main content
          Expanded(
            child: Container(
              color: Color(0xFFF5EEDC),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'lib/assets/logo1.png',
                    fit: BoxFit.cover,
                  ),
                  Text(
                    "Grade 6",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.green.shade900,
                      fontFamily: 'Lakki Reddy',
                    ),
                  ),
                  SizedBox(height: 20),
                  Image.asset(
                    'lib/assets/tutor.png',
                    fit: BoxFit.cover,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _sidebarButton(BuildContext context, String text, [bool isSelected = false]) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : Colors.green.shade900,
          borderRadius: BorderRadius.circular(5),
        ),
        child: TextButton(
          onPressed: () {
            _navigateToScreen(context, text);
          },
          child: Text(
            text,
            style: TextStyle(
              color: isSelected ? Color(0XFF123524) : Color(0xFFEFE3C2),
            ),
          ),
        ),
      ),
    );
  }

  void _navigateToScreen(BuildContext context, String screen) {
    switch (screen) {
      case "Home":
        Navigator.push(context, MaterialPageRoute(builder: (context) => MyApp()));
        break;
      case "Students":
        Navigator.push(context, MaterialPageRoute(builder: (context) => RegistrationScreen()));
        break;
      case "Classes":
        Navigator.push(context, MaterialPageRoute(builder: (context) => ClassesScreen()));
        break;
      case "Attendance":
        Navigator.push(context, MaterialPageRoute(builder: (context) => AttendanceScreen()));
        break;
      case "Payment":
        Navigator.push(context, MaterialPageRoute(builder: (context) => PaymentScreen()));
        break;
      case "Attendance Report":
        Navigator.push(context, MaterialPageRoute(builder: (context) => AttendanceRecordsScreen()));
        break;
    }
  }
}

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {

  final _nameController = TextEditingController();
  final _tellController = TextEditingController();
  final _addressController = TextEditingController();
  int? _editingId;
  List<Student> _students = [];

  @override
  void initState() {
    super.initState();
    _refreshStudents();
  }

  Future<void> _refreshStudents() async {
    final data = await DBHelper.instance.fetchStudents();
    setState(() {
      _students = data.map((e) => Student.fromMap(e)).toList();
    });
  }

  Future<void> _addOrUpdateStudent() async {
    final name = _nameController.text.trim();
    final tell = _tellController.text.trim();
    final address = _addressController.text.trim();

    if (name.isEmpty || tell.isEmpty || address.isEmpty) return;

    if (_editingId == null) {
      await DBHelper.instance.insertStudent(Student(name: name, tell: tell, address: address,));
    } else {
      await DBHelper.instance.updateStudent(Student(id: _editingId, name: name, tell: tell, address: address));
    }

    _nameController.clear();
    _tellController.clear();
    _addressController.clear();
    _editingId = null;
    _refreshStudents();
  }

  void _editStudent(Student student) {
    _nameController.text = student.name;
    _tellController.text = student.tell;
    _addressController.text = student.address;
    _editingId = student.id;
  }

  Future<void> _deleteStudent(int id) async {
    await DBHelper.instance.deleteStudent(id);
    _refreshStudents();
  }
  Future<Student?> showUpdateDialog(BuildContext context, Student student) async {
    TextEditingController nameController = TextEditingController(text: student.name);
    TextEditingController tellController = TextEditingController(text: student.tell);
    TextEditingController addressController = TextEditingController(text: student.address);

    return await showDialog<Student>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Update Student'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(labelText: 'Name'),
                ),
                TextField(
                  controller: tellController,
                  decoration: const InputDecoration(labelText: 'Telephone'),
                ),
                TextField(
                  controller: addressController,
                  decoration: const InputDecoration(labelText: 'Address'),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(null); // Return null if cancelled
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () async {
                await DBHelper.instance.updateStudent( Student(
                  id: student.id,
                  name: nameController.text,
                  tell: tellController.text,
                  address: addressController.text,
                ));
                Navigator.of(context).pop();
                _refreshStudents();
                 // Return updated student
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0XFF123524),
        title: Center(
          child: Text(
            "Tuition Management System",
            style: TextStyle(
              color: Color(0xFFEFE3C2),
              fontSize: 15.0,
              fontWeight: FontWeight.bold,
              fontFamily: 'Krona One',
            ),
          ),
        ),
      ),
      body: Container(
        color: Color(0xFFF5EEDC), // <<< whole screen background color
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Students',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0XFF123524), // <<< text white to match background
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _students.length,
                itemBuilder: (context, index) {
                  final student = _students[index];
                  return Card(
                    child: ListTile(
                      title: Text('${student.id}: ${student.name}'),
                      subtitle: Text(
                        'Parent`s Telephone NO: ${student.tell}\nAddress: ${student.address}',
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit, color: Colors.green),
                            onPressed: () async {
                              Student? updatedStudent = await showUpdateDialog(context, student);
                              if (updatedStudent != null) {
                                await DBHelper.instance.updateStudent(updatedStudent);
                                setState(() {}); // Refresh UI
                              }
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () => _deleteStudent(student.id!),
                          ),
                        ],
                      ),
                      onTap: () async {
                        final payments = await DBHelper.instance.fetchPaymentsByStudentId(student.id!);
                        final attendanceCount = await DBHelper.instance.fetchAttendanceCountByStudentId(student.id!);

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => StudentDetailScreen(
                              student: student,
                              payments: payments,
                              attendanceCount: attendanceCount,
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),


      floatingActionButton:

        FloatingActionButton(
        onPressed: () {
      _showAddStudentForm(context);
    },
    backgroundColor: Colors.green,
    child: const Text(
    'Add',
    style: TextStyle(
    fontSize: 14,  // Adjust the font size as needed
    color: Colors.white,
    ),
    ),
    ),
      );

  }

  Widget buildItem(String text) {
    return Container(
      width: 110,
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.black, width: 2),
        borderRadius: BorderRadius.circular(0),
      ),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.green,
          ),
        ),
      ),
    );
  }

  void _showAddStudentForm(BuildContext context) {

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add Student Details'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
               TextField(controller: _nameController, decoration: const InputDecoration(labelText: 'Name')),
              TextField(controller: _tellController, decoration: const InputDecoration(labelText: 'Parent’s Telephone')),
              TextField(controller: _addressController, decoration: const InputDecoration(labelText: 'Address')),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
        TextButton(
        onPressed: () {
        _addOrUpdateStudent();
        Navigator.of(context).pop();
        },
        child: Text(_editingId == null ? 'Add Student' : 'Update Student'),
        ),

          ],
        );
      },
    );
  }
}

class ClassesScreen extends StatefulWidget {
  const ClassesScreen({super.key});
  @override
  State<ClassesScreen> createState() => ClassesScreenState();
}

class ClassesScreenState extends State< ClassesScreen> {

  final _dateController = TextEditingController();
  final _timeController = TextEditingController();
  int? _editingId;
  List<Classes> _classes = [];

  @override
  void initState() {
    super.initState();
    _refreshclasse();
  }

  Future<void> _refreshclasse() async {
    final data = await DBHelper.instance.fetchclasses();
    setState(() {
      _classes = data.map((e) => Classes.fromMap(e)).toList();
    });
  }

  Future<void> _addOrUpdateStudent() async {
    final date = _dateController.text.trim();
    final time = _timeController.text.trim();

    if (date.isEmpty || time.isEmpty) return;

    if (_editingId == null) {
      await DBHelper.instance.insertclass(Classes(date: date, time: time));
    } else {
      await DBHelper.instance.updateclass(Classes(
        id: _editingId, // << add id here
        date: date,
        time: time,
      ));
    }

    _dateController.clear();
    _timeController.clear();
    _editingId = null;
    _refreshclasse();
  }

  Future<void> _deleteclass(int id) async {
    await DBHelper.instance.deleteclass9(id);
    _refreshclasse();
  }

  Future<Classes?> showUpdateDialog(BuildContext context, Classes classes) async {
    DateTime selectedDate = DateTime.tryParse(classes.date) ?? DateTime.now();
    TimeOfDay selectedTime = TimeOfDay(
      hour: int.tryParse(classes.time.split(":")[0]) ?? 0,
      minute: int.tryParse(classes.time.split(":")[1]) ?? 0,
    );
    Future<void> sendSmsToAllStudents(String date, String time) async {
      final Telephony telephony = Telephony.instance;

      bool? permissionsGranted = await telephony.requestPhoneAndSmsPermissions;
      if (permissionsGranted == true) {
        try {
          final studentData = await DBHelper.instance.fetchStudents();

          // SAFELY map the phone numbers
          final phoneNumbers = studentData
              .map<String>((e) => (e['tell'] ?? '').toString())
              .where((number) => number.isNotEmpty)
              .toList();

          String message = "Important Update: Your class is rescheduled to $date at $time.";

          for (String number in phoneNumbers) {
            await telephony.sendSms(
              to: number,
              message: message,
            );
          }
          print("Messages sent successfully!");

          // Show success toast after sending all messages
          Fluttertoast.showToast(
            msg: "SMS sent successfully to all students!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0,
          );
        } catch (e) {
          print("Error while sending messages: $e");
        }
      } else {
        print("SMS permission not granted!");
      }
    }
    return await showDialog<Classes>(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text('Update Class'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    leading: const Icon(Icons.calendar_today),
                    title: Text('Date: ${selectedDate.toLocal().toString().split(' ')[0]}'),
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: selectedDate,
                        firstDate: DateTime(2020),
                        lastDate: DateTime(2100),
                      );
                      if (pickedDate != null) {
                        setState(() {
                          selectedDate = pickedDate; // Update selected date
                        });
                      }
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.access_time),
                    title: Text('Time: ${selectedTime.format(context)}'),
                    onTap: () async {
                      TimeOfDay? pickedTime = await showTimePicker(
                        context: context,
                        initialTime: selectedTime,
                      );
                      if (pickedTime != null) {
                        setState(() {
                          selectedTime = pickedTime; // Update selected time
                        });
                      }
                    },
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(null); // Cancel update
                  },
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () async {
                    final updatedDate = selectedDate.toIso8601String().split('T').first;
                    final updatedTime = '${selectedTime.hour.toString().padLeft(2, '0')}:${selectedTime.minute.toString().padLeft(2, '0')}';

                    // First, update the class and pop
                    Navigator.of(context).pop(Classes(
                      id: classes.id, // Keep the original ID
                      date: updatedDate,
                      time: updatedTime,
                    ));

                    // Then, send SMS to all students
                    await sendSmsToAllStudents(updatedDate, updatedTime);
                  },
                  child: const Text('Save'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0XFF123524),
        title: Center(
          child: Text(
            "Tuition Management System",
            style: TextStyle(
              color: Color(0xFFEFE3C2),
              fontSize: 15.0,
              fontWeight: FontWeight.bold,
              fontFamily: 'Krona One',
            ),
          ),
        ),
      ),
      body: Container(
        color: Color(0xFFF5EEDC), // <<< whole screen background color
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Classes',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(
                      0XFF123524), // <<< text white to match background
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _classes.length,
                itemBuilder: (context, index) {
                  final classes = _classes[index];
                  return Card(
                    child: ListTile(
                      title: Text(classes.date),
                      subtitle: Text(classes.time),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit, color: Colors.green),
                            onPressed: () async {
                              Classes? updatedClass = await showUpdateDialog(
                                  context, classes);
                              if (updatedClass != null) {
                                await DBHelper.instance.updateclass(
                                    updatedClass);
                                _refreshclasse(); // << refresh after updating
                              }
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () => _deleteclass(classes.id!),
                          ),
                        ],
                      ),

                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),


      floatingActionButton:

        FloatingActionButton(
          onPressed: () {
            _showAddclassForm(context);
          },
          backgroundColor: Colors.green,
          child: const Text(
            'Add',
            style: TextStyle(
              fontSize: 14,  // Adjust the font size as needed
              color: Colors.white,
            ),
          ),
    ),
    );


  }

  Widget buildItem(String text) {
    return Container(
      width: 110,
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.black, width: 2),
        borderRadius: BorderRadius.circular(0),
      ),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.green,
          ),
        ),
      ),
    );
  }

  void _showAddclassForm(BuildContext context) {
    DateTime selectedDate = DateTime.now();
    TimeOfDay selectedTime = TimeOfDay.now();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder( // <-- add StatefulBuilder here
          builder: (context, setState) {
            return AlertDialog(
              title: Text('Class Details'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ListTile(
                    leading: const Icon(Icons.calendar_today),
                    title: Text('Date: ${selectedDate.toLocal().toString().split(' ')[0]}'),
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: selectedDate,
                        firstDate: DateTime(2020),
                        lastDate: DateTime(2100),
                      );
                      if (pickedDate != null) {
                        setState(() {
                          selectedDate = pickedDate;
                        });
                      }
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.access_time),
                    title: Text('Time: ${selectedTime.format(context)}'),
                    onTap: () async {
                      TimeOfDay? pickedTime = await showTimePicker(
                        context: context,
                        initialTime: selectedTime,
                      );
                      if (pickedTime != null) {
                        setState(() {
                          selectedTime = pickedTime;
                        });
                      }
                    },
                  ),
                ],
              ),
              actions: <Widget>[
                TextButton(
                  child: const Text('Cancel'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  onPressed: () async {
                    final date = selectedDate.toIso8601String().split('T').first;
                    final time = '${selectedTime.hour.toString().padLeft(2, '0')}:${selectedTime.minute.toString().padLeft(2, '0')}';
                    await DBHelper.instance.insertclass(Classes(date: date, time: time));
                    Navigator.of(context).pop();
                    _refreshclasse();
                  },
                  child: const Text('Add Class'),
                ),
              ],
            );
          },
        );
      },
    );
  }
}

class AttendanceScreen extends StatefulWidget {
  const AttendanceScreen({super.key});

  @override
  _AttendanceScreenState createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  List<Student> _students = [];
  Map<int, bool> _presentStatus = {}; // true = present, false = absent
  DateTime _selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    _loadStudents();
  }

  Future<void> _loadStudents() async {
    final studentMaps = await DBHelper.instance.getAllStudents();
    setState(() {
      _students = studentMaps.map((e) => Student.fromMap(e)).toList();
      for (var student in _students) {
        _presentStatus[student.id!] = false; // default to absent
      }
    });
  }

  Future<void> _saveAttendance() async {
    String formattedDate = _selectedDate.toIso8601String().split('T').first;

    for (var entry in _presentStatus.entries) {
      final attendance = Attendance(
        studentId: entry.key,
        date: formattedDate,
        isPresent: entry.value,
      );
      await DBHelper.instance.insertAttendance(attendance.toMap());

      // Increment the attendance count only for present students
      if (entry.value) { // Check if the student is present
        await DBHelper.instance.incrementStudentAttendance(entry.key);
      }
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Attendance saved successfully!')),
    );
    Navigator.pop(context);
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5EEDC), // Add background color here
      appBar: AppBar( backgroundColor: Color(0XFF123524),
        title: Center(
          child: Text(
            "Tuition Management System",
            style: TextStyle(
              color: Color(0xFFEFE3C2),
              fontSize: 15.0,
              fontWeight: FontWeight.bold,
              fontFamily: 'Krona One',
            ),
          ),
        ),
      ),
      body: Column(


        children: [
          Container(
            color: Colors.teal[50],
            child: ListTile(
              leading: const Icon(Icons.date_range, color:  Color(0XFF123524)),
              title: Text(
                'Date: ${_selectedDate.toLocal().toString().split(' ')[0]}',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              trailing: ElevatedButton.icon(
                onPressed: _pickDate,
                icon: const Icon(Icons.calendar_today),
                label: const Text('Pick Date'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0XFF123524),
                  foregroundColor: Colors.white,
                ),
              ),
            ),
          ),
          const Divider(thickness: 2),
          Expanded(
            child: _students.isEmpty
                ? const Center(child: Text('No Students Found'))
                : ListView.builder(
              itemCount: _students.length,
              itemBuilder: (context, index) {
                final student = _students[index];
                final isPresent = _presentStatus[student.id] ?? false;

                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ListTile(
                    title: Text(
                      student.name,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                _presentStatus[student.id!] = true;
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: isPresent ? Colors.green : Colors.grey[300],
                              foregroundColor: isPresent ? Colors.white : Colors.black,
                            ),
                            child: const Text('Present'),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                _presentStatus[student.id!] = false;
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: !isPresent ? Colors.red : Colors.grey[300],
                              foregroundColor: !isPresent ? Colors.white : Colors.black,
                            ),
                            child: const Text('Absent'),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _saveAttendance,
        backgroundColor:  Color(0XFF123524),
        foregroundColor: Colors.white,
        icon: const Icon(Icons.save),
        label: const Text('Save Attendance'),



      ),
    );


  }
}



class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final _studentIdController = TextEditingController();
  final _amountController = TextEditingController();
  final _descriptionController = TextEditingController();
  DateTime? _selectedDate; // <-- Changed here
  List<Payment> _payments = [];
  int? _editingPaymentId;

  @override
  void initState() {
    super.initState();
    _fetchPayments();
  }

  Future<void> _fetchPayments() async {
    final data = await DBHelper.instance.fetchPayments();
    setState(() {
      _payments = data.map((e) => Payment.fromMap(e)).toList();
    });
  }

  Future<void> _addOrUpdatePayment() async {
    final studentId = int.tryParse(_studentIdController.text.trim());
    final amount = double.tryParse(_amountController.text.trim());
    final description = _descriptionController.text.trim();

    if (studentId == null || amount == null || _selectedDate == null) return;

    final formattedDate = _selectedDate!.toIso8601String().split('T').first;

    if (_editingPaymentId == null) {
      await DBHelper.instance.insertPayment(
        Payment(
          studentId: studentId,
          amount: amount,
          date: formattedDate,
          description: description,
        ),
      );
    }

    _studentIdController.clear();
    _amountController.clear();
    _descriptionController.clear();
    _selectedDate = null;
    _editingPaymentId = null;
    _fetchPayments();
  }

  void _editPayment(Payment payment) {
    _studentIdController.text = payment.studentId.toString();
    _amountController.text = payment.amount.toString();
    _selectedDate = DateTime.tryParse(payment.date);
    _descriptionController.text = payment.description ?? '';
    _editingPaymentId = payment.id;
  }

  Future<void> _deletePayment(int id) async {
    await DBHelper.instance.deletePayment(id);
    _fetchPayments();
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFF5EEDC),
    appBar: AppBar( backgroundColor: Color(0XFF123524),
    title: Center(
    child: Text(
    "Tuition Management System",
    style: TextStyle(
    color: Color(0xFFEFE3C2),
    fontSize: 15.0,
    fontWeight: FontWeight.bold,
    fontFamily: 'Krona One',
    ),
    ),
    ),
    ),
      body:  Column(
      crossAxisAlignment: CrossAxisAlignment.start, // Align text to the start
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 16),
          child: Center(
            child: Text(
              "Payments",
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Colors.green, // You can change color if needed
              ),
            ),
          ),
        ),
        TextField(
          controller: _studentIdController,
          decoration: const InputDecoration(labelText: "Student ID"),
          keyboardType: TextInputType.number,
        ),
        TextField(
          controller: _amountController,
          decoration: const InputDecoration(labelText: "Amount"),
          keyboardType: TextInputType.number,
        ),
        const SizedBox(height: 8),
        ListTile(
          leading: const Icon(Icons.date_range),
          title: Text(
            _selectedDate == null
                ? 'Select Date'
                : 'Date: ${_selectedDate!.toLocal().toString().split(' ')[0]}',
          ),
          trailing: ElevatedButton(
            onPressed: _pickDate,
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xff85A947),
              foregroundColor: Colors.white,
            ),
            child: const Text('Pick Date'),
          ),
        ),
        TextField(
          controller: _descriptionController,
          decoration: const InputDecoration(labelText: "Description"),
        ),
        const SizedBox(height: 10),
        ElevatedButton(
          onPressed: _addOrUpdatePayment,
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xff85A947),
          ),
          child: Text(
            _editingPaymentId == null ? "Add Payment" : "Update Payment",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
        const SizedBox(height: 20),
        Expanded(
          child: ListView.builder(
            itemCount: _payments.length,
            itemBuilder: (context, index) {
              final payment = _payments[index];
              return Card(
                child: ListTile(
                  title: Text("Student ID: ${payment.studentId}"),
                  subtitle: Text("Amount: ${payment.amount}\nDate: ${payment.date}\n${payment.description ?? ''}"),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () => _deletePayment(payment.id!),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    ),
    );
  }
}

class AttendanceRecordsScreen extends StatefulWidget {
  const AttendanceRecordsScreen({super.key});

  @override
  State<AttendanceRecordsScreen> createState() => _AttendanceRecordsScreenState();
}



class _AttendanceRecordsScreenState extends State<AttendanceRecordsScreen> {
  Map<String, List<Student>> _attendanceRecords = {};

  @override
  void initState() {
    super.initState();
    _loadAttendanceRecords();
  }

  Future<void> _loadAttendanceRecords() async {
    final db = await DBHelper.instance.database;

    // Query JOIN from attendance and students
    final records = await db.rawQuery('''
      SELECT a.date, s.id, s.name
      FROM attendance a
      INNER JOIN students s ON a.studentId = s.id
      WHERE a.isPresent = 1
      ORDER BY a.date DESC
    ''');

    Map<String, List<Student>> tempRecords = {};

    for (var record in records) {
      final String date = record['date'] as String;
      final Student student = Student(
        id: record['id'] as int,
        name: record['name'] as String,
       tell: record['name'] as String,
        address:record['name'] as String, // Same for address.
      );

      if (!tempRecords.containsKey(date)) {
        tempRecords[date] = [];
      }
      tempRecords[date]!.add(student);
    }

    setState(() {
      _attendanceRecords = tempRecords;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<String> sortedDates = _attendanceRecords.keys.toList()
      ..sort((a, b) => b.compareTo(a)); // Latest first

    return Scaffold(
      backgroundColor: Color(0xFFEFE3C2), // Add background color here
      appBar: AppBar( backgroundColor: Color(0XFF123524),
        title: Center(
          child: Text(
            "Tuition Management System",
            style: TextStyle(
              color: Color(0xFFEFE3C2),
              fontSize: 15.0,
              fontWeight: FontWeight.bold,
              fontFamily: 'Krona One',
            ),
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(12),
        color: const  Color(0xFFF5EEDC),
        child: _attendanceRecords.isEmpty
            ? const Center(
          child: Text(
            'No Attendance Records Found!',
            style: TextStyle(fontSize: 18),
          ),
        )
            : ListView.builder(
          itemCount: sortedDates.length,
          itemBuilder: (context, index) {
            String date = sortedDates[index];
            List<Student> students = _attendanceRecords[date]!;

            return Card(
              elevation: 4,
              margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: ExpansionTile(
                backgroundColor: Colors.white,
                collapsedBackgroundColor: Colors.white,
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Date: $date',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color:Color(0XFF123524),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color:Colors.lightGreenAccent,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        '${students.length} attended',
                        style: const TextStyle(fontSize: 14),
                      ),
                    ),
                  ],
                ),
                children: students.map((student) {
                  return ListTile(
                    leading: const Icon(Icons.person, color: Colors.teal),
                    title: Text(
                      student.name,
                      style: const TextStyle(fontSize: 16),
                    ),
                  );
                }).toList(),
              ),
            );
          },
        ),
      ),
    );
  }
}


