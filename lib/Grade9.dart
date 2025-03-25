import 'package:flutter/material.dart';
import 'package:tmms/main.dart';

void main() {
  runApp(Grade9());
}

class Grade9 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
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
            color: Color(0xff85A947),
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
                    Navigator.pop(context);
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
                  Image.asset('/logo1.png', width: 100),
                  SizedBox(height: 20),
                  Text(
                    "Grade 9",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color:  Color(0xff85A947),
                      fontFamily: 'Lakki Reddy',
                    ),
                  ),
                  SizedBox(height: 20),
                  Image.asset('/ch5.png', width: 250),
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
        Navigator.push(context, MaterialPageRoute(builder: (context) => StudentsScreen()));
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
        Navigator.push(context, MaterialPageRoute(builder: (context) => AttendanceReportScreen()));
        break;
    }
  }
}

class StudentsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Students")),
      body: Center(child: Text("Students Screen")),
    );
  }
}

class ClassesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Classes")),
      body: Center(child: Text("Classes Screen")),
    );
  }
}

class AttendanceScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Attendance")),
      body: Center(child: Text("Attendance Screen")),
    );
  }
}

class PaymentScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Payment")),
      body: Center(child: Text("Payment Screen")),
    );
  }
}

class AttendanceReportScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Attendance Report")),
      body: Center(child: Text("Attendance Report Screen")),
    );
  }
}
