class Student {
  final int? id;
  final String name;
  final String tell;
  final String address;

  Student({this.id, required this.name, required this.tell, required this.address});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'parentContact':tell,
      'address': address,
    };
  }

  factory Student.fromMap(Map<String, dynamic> map) {
    return Student(
      id: map['id'],
      name: map['name'],
     tell: map['parentContact'],
      address: map['address'],
    );
  }
}
