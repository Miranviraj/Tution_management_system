import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:share_plus/share_plus.dart';
import '../models/student.dart'; // adjust if path different
import '../models/payment.dart'; // adjust if path different

class SharePDFService {
  static Future<void> shareStudentReceipt({
    required Student student,
    required List<Payment> payments,
    required int attendanceCount,
  }) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text("Student Receipt", style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold)),
              pw.SizedBox(height: 20),
              pw.Text("Name: ${student.name}", style: pw.TextStyle(fontSize: 18)),
              pw.Text("Telephone: ${student.tell}", style: pw.TextStyle(fontSize: 18)),
              pw.Text("Address: ${student.address}", style: pw.TextStyle(fontSize: 18)),
              pw.SizedBox(height: 20),
              pw.Text("Attendance Count: $attendanceCount", style: pw.TextStyle(fontSize: 18)),
              pw.SizedBox(height: 20),
              pw.Text("Payments:", style: pw.TextStyle(fontSize: 20, fontWeight: pw.FontWeight.bold)),
              pw.SizedBox(height: 10),
              ...payments.map((p) => pw.Container(
                margin: const pw.EdgeInsets.only(bottom: 8),
                child: pw.Text("• Amount: ${p.amount}, Date: ${p.date}, Desc: ${p.description ?? 'No description'}", style: pw.TextStyle(fontSize: 16)),
              )),
            ],
          );
        },
      ),
    );

    final output = await getTemporaryDirectory();
    final file = File("${output.path}/${student.name}_receipt.pdf");
    await file.writeAsBytes(await pdf.save());

    await Share.shareXFiles([XFile(file.path)], text: "Payment Receipt for ${student.name}");
  }
}
