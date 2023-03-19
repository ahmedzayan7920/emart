class UserModel {
  final String uid;
  final String name;
  final String email;
  final String profileUrl;
  final bool isAdmin;
  final int cartCount;
  final int orderCount;
  final int wishlistCount;

  UserModel({
    required this.uid,
    required this.name,
    required this.email,
    required this.profileUrl,
    required this.isAdmin,
    required this.cartCount,
    required this.orderCount,
    required this.wishlistCount,
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'profileUrl': profileUrl,
      'isAdmin': isAdmin,
      'cartCount': cartCount,
      'orderCount': orderCount,
      'wishlistCount': wishlistCount,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] as String,
      name: map['name'] as String,
      email: map['email'] as String,
      profileUrl: map['profileUrl'] as String,
      isAdmin: map['isAdmin'] as bool,
      cartCount: map['cartCount'] as int,
      orderCount: map['orderCount'] as int,
      wishlistCount: map['wishlistCount'] as int,
    );
  }
}
