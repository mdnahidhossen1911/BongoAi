class AuthUser {
  final String uuid;
  final String name;
  final String? image;
  final String? behavior;

  AuthUser({required this.uuid, required this.name, this.image, this.behavior});

  Map<String, dynamic> toJson() => {
    'uuid': uuid,
    'name': name,
    'image': image,
    'behavior': behavior,
  };

  factory AuthUser.fromJson(Map<String, dynamic> json) => AuthUser(
    uuid: json['uuid'] as String,
    name: json['name'] as String,
    image: json['image'] as String?,
    behavior: json['behavior'] as String?,
  );
}
