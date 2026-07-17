class UserModel {
  final String id;
  final String email;
  final String name;
  final List<dynamic> favorite;

  UserModel({
    required this.id,
    required this.email,
    required this.name,
    required this.favorite,
  });
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'favorite': favorite,
    };
  }
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? '',
      email: json['email'] ?? '',
      name: json['name'] ?? '',
      favorite: json['favorite'] ,
    );
  }
}
