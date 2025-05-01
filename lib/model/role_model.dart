class RoleModel {
  final String id;
  final String name;
  final String normalizedName;

  RoleModel( { required this.normalizedName,required this.id, required this.name});

  factory RoleModel.fromJson(Map<String, dynamic> json) {
    return RoleModel(
      id: json['id'],
      name: json['name'],
      normalizedName: json['normalizedName'],
    );
  }
}
