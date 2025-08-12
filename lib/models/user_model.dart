class UserModel {
  String uid;
  String? fullName;
  String? shortName;
  String? description;
  String? photo;
  String email;

  UserModel({
    required this.uid,
    this.shortName,
    this.description,
    this.fullName,
    this.photo,
    required this.email,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uid: json['id'] ?? '',
      fullName: json['name'] ?? '',
      shortName: json['short_name'] ?? '',
      description: json['description'] ?? '',
      photo: json['photo'] ?? '',
      email: json['email'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.uid;
    data['name'] = this.fullName;
    data['photo'] = this.photo;
    data['email'] = this.email;
    data['short_name'] = this.shortName;
    data['description'] = this.description;
    return data;
  }
}
