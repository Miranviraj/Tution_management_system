import 'package:flutter/material.dart';
import 'package:untitled11/screens/Grade6.dart';
import 'package:untitled11/screens/Grade7.dart';
import 'package:untitled11/screens/Grade8.dart';
import 'package:untitled11/screens/Grade9.dart';
import 'package:untitled11/screens/Grade10.dart';
import 'package:untitled11/screens/Grade11.dart';
import 'package:untitled11/screens/report_screen.dart';


void main()  {



  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tuition Management System',
      debugShowCheckedModeBanner: false,
      home: HomeScreen(), // Use a separate widget for home
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
      body: Container(
        color: Color(0xFFEFE3C2),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
                width: 100,
                height: 100,
                child: Image.asset(
                  'lib/assets/logo1.png',
                  fit: BoxFit.cover,
                )
              // Ensure the correct path
            ),
            SizedBox(height: 20),
            Text('Select A Grade', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 30),

            // Grade Buttons
            _buildGradeButtons(context),
            SizedBox(height: 50),

            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ReportScreen()),);
              },
              style: _buttonStyle(),
              child: Text('  Reports'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGradeButtons(BuildContext context) {
    return Column(
      children: [
        _buildRow(context, 'Grade 6', () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Grade6()),
          );
        }, 'Grade 7', () { Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Grade7()),);
        }),
        SizedBox(height: 20),
        _buildRow(context, 'Grade 8', () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Grade8()),);
        }, 'Grade 9', () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Grade9()),);
        }),
        SizedBox(height: 20),
        _buildRow(context, 'Grade 10', () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Grade10()),);
        }, 'Grade 11', () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Grade11()),);
        }),
      ],
    );
  }

  Widget _buildRow(BuildContext context, String title1, VoidCallback onPressed1, String title2, VoidCallback onPressed2) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        ElevatedButton(
          onPressed: onPressed1,
          style: _buttonStyle(),
          child: Text(title1),
        ),
        SizedBox(width: 40),
        ElevatedButton(
          onPressed: onPressed2,
          style: _buttonStyle(),
          child: Text(title2),
        ),
      ],
    );
  }

  ButtonStyle _buttonStyle() {
    return ButtonStyle(
      backgroundColor: WidgetStateProperty.all<Color>(Color(0XFF3E7B27)),
      foregroundColor: WidgetStateProperty.all<Color>(Color(0xFFEFE3C2)),
    );
  }
}
