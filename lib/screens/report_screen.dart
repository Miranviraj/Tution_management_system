import 'package:flutter/material.dart';
import '../db/db_helper.dart';

class ReportScreen extends StatelessWidget {
  const ReportScreen({super.key});

  Future<Map<String, dynamic>> _generateReport() async {
    final totalStudents = await DBHelper.instance.fetchStudents();
    final totalPayments = await DBHelper.instance.fetchPayments();
    final totalAttendance = await DBHelper.instance.fetchAttendance();
    return {
      'students': totalStudents,
      'payments': totalPayments,
      'attendances': totalAttendance,
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Tuition Management System",
          style: TextStyle(fontWeight: FontWeight.bold,
            color: Colors.white,

          ),
        ),
        backgroundColor:Color(0XFF123524),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: _generateReport(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return const Center(child: Text("Error loading report"));
          }

          final data = snapshot.data!;
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(    // 🛠️ Add this
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      "Summary Report",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.indigo,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  ReportCard(
                    title: "Total Students",
                    value: "${data['students']}",
                    icon: Icons.person,
                    color: Colors.blue,
                  ),
                  const SizedBox(height: 16),
                  ReportCard(
                    title: "Total Payments",
                    value: "Rs. ${data['payments']}",
                    icon: Icons.payment,
                    color: Colors.green,
                  ),
                  const SizedBox(height: 16),
                  ReportCard(
                    title: "Total Attendances",
                    value: "${data['attendances']}",
                    icon: Icons.check_circle,
                    color: Colors.orange,
                  ),
                ],
              ),
            ),
          );

        },
      ),
    );
  }
}

class ReportCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const ReportCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: color,
          child: Icon(icon, color: Colors.white),
        ),
        title: Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        subtitle: Text(
          value,
          style: const TextStyle(fontSize: 16, color: Colors.black87),
        ),
      ),
    );
  }
}
