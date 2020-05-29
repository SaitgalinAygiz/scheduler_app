class Consultation {
  String name;
  String description;
  String consultationType;
  String teacher;
  DateTime time;
  List<dynamic> students;

  Consultation({
    this.name,
    this.description,
    this.consultationType,
    this.teacher,
    this.time,
    this.students
  });

  factory Consultation.fromJson(Map<String, dynamic> json) {
    return Consultation(
      name: json['name'],
      description: json['description'],
      consultationType: json['consultationType'],
      teacher: json['teacher'],
      time: DateTime.parse(json['time']),
      students: (json['students'])
    );
  }
}