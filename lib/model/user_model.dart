class UserModel {
  final String id;
  final String name;
  final String userName;
  final String role;
  final List<dynamic> groups;

  UserModel({required this.id, required this.name, required this.userName, required this.role, required this.groups});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id : json["id"],
      name: json['name'],
      userName: json['userName'],
      role: json['role'],
      groups: json['groups']??[],
    );
  }
}
