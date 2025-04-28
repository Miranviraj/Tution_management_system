class Classes {
  final int? id;
  final String date;
  final String time;


  Classes({this.id, required this.date, required this.time});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'date': date,
      'time':time,

    };
  }

  factory Classes.fromMap(Map<String, dynamic> map) {
    return Classes(
      id: map['id'],
      date: map['date'],
     time: map['time'],

    );
  }
}
