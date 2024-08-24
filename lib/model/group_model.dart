class Group {
  final int id;
  final String name;
  final String teacherName;
  final int studentsCount;

  Group( { required this.teacherName,required this.id, required this.name,required this.studentsCount});

  factory Group.fromJson(Map<String, dynamic> json) {
    return Group(
      id: json['id'],
      name: json['name'],
      teacherName: json['teacherName']??"", studentsCount: json['studentsCount'],
    );
  }
}
