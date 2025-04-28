class Payment {
  final int? id;
  final int studentId;
  final double amount;
  final String date;
  final String description;

  Payment({this.id, required this.studentId, required this.amount, required this.date, required this.description});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'studentId': studentId,
      'amount': amount,
      'date': date,
      'description': description,
    };
  }

  factory Payment.fromMap(Map<String, dynamic> map) {
    return Payment(
      id: map['id'],
      studentId: map['studentId'],
      amount: map['amount'],
      date: map['date'],
      description: map['description'],
    );
  }
}
