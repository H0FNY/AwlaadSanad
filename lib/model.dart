class AttendenceTypeModel {
  int? id;
  String? type;

  AttendenceTypeModel(
      {required this.id,
        required this.type});

  factory AttendenceTypeModel.fromJson(dynamic data) {
    return AttendenceTypeModel(
        id: data['id'],
        type: data['type']);
  }
}
