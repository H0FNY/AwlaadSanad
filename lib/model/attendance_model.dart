class AttendanceModel {
  final int id;
  final String description;
  final String date;
  final int studentId;
  final int attendId;

  AttendanceModel(  { required this.id,required this.description,required this.date,required this.studentId,required this.attendId,});

  factory AttendanceModel.fromJson(Map<String, dynamic> json) {
    return AttendanceModel(
      id: json['id'],
      description: json['description'],
      date: json['date'],
      studentId: json['studentId'],
      attendId: json['attendId'],
    );
  }
}
