class UserModel {
  final int id;
  final String name;
  final String username;
  final RoleModel role;
  final ClassModel userClass;

  UserModel({
    required this.id,
    required this.name,
    required this.username,
    required this.role,
    required this.userClass,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      username: json['username'],
      role: RoleModel.fromJson(json['role']),
      userClass: ClassModel.fromJson(json['class']),
    );
  }
}

class RoleModel {
  final int id;
  final String name;

  RoleModel({required this.id, required this.name});

  factory RoleModel.fromJson(Map<String, dynamic> json) {
    return RoleModel(id: json['id'], name: json['name']);
  }
}

class ClassModel {
  final int id;
  final String name;

  ClassModel({required this.id, required this.name});

  factory ClassModel.fromJson(Map<String, dynamic> json) {
    return ClassModel(id: json['id'], name: json['name']);
  }
}