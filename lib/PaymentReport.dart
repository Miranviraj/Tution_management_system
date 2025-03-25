// Page1.dart
import 'package:flutter/material.dart';

void main() {
  runApp(Paymentreport());
}

class Paymentreport extends StatelessWidget {
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
    );
  }
}
