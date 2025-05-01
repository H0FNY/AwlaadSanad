import 'group_model.dart';

class StudentModel {
  final int id;
  final String name;
  final String groupName;
  final String phoneNumber;

  StudentModel({required this.id, required this.name, required this.groupName,required this.phoneNumber});

  factory StudentModel.fromJson(Map<String, dynamic> json) {
    return StudentModel(
      id : json["id"],
      name: json['name'],
      groupName: json['groupName']??"",
      phoneNumber: json['phoneNumber']??"",

    );
  }
}


class SearchStudentModel {
  final int id;
  final String name;
  final int groupId;
  final String phoneNumber;

  SearchStudentModel({required this.id, required this.name, required this.groupId,required this.phoneNumber});

  factory SearchStudentModel.fromJson(Map<String, dynamic> json) {
    return SearchStudentModel(
      id : json["id"],
      name: json['name'],
      groupId: json['groupId']??0,
      phoneNumber: json['phoneNumber']??"",
    );
  }
}
