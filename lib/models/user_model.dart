class UserModel {
  final String uid;
  final String name;
  final String email;
  final String profileUrl;
  final bool isUser;

  UserModel({
    required this.uid,
    required this.name,
    required this.email,
    required this.profileUrl,
    required this.isUser,
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'profileUrl': profileUrl,
      'isUser': isUser,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] as String,
      name: map['name'] as String,
      email: map['email'] as String,
      profileUrl: map['profileUrl'] as String,
      isUser: map['isUser'] as bool,
    );
  }
}
