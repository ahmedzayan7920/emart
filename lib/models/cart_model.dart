class CartModel {
  final String name;
  final String image;
  final num color;
  final num quantity;
  final num totalPrice;
  final String seller;
  final String sellerId;
  final String userId;

  CartModel({
    required this.name,
    required this.image,
    required this.color,
    required this.quantity,
    required this.totalPrice,
    required this.seller,
    required this.sellerId,
    required this.userId,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'image': image,
      'color': color,
      'quantity': quantity,
      'totalPrice': totalPrice,
      'seller': seller,
      'sellerId': sellerId,
      'userId': userId,
    };
  }

  factory CartModel.fromMap(Map<String, dynamic> map) {
    return CartModel(
      name: map['name'] as String,
      image: map['image'] as String,
      color: map['color'] as num,
      quantity: map['quantity'] as num,
      totalPrice: map['totalPrice'] as num,
      seller: map['seller'] as String,
      sellerId: map['sellerId'] as String,
      userId: map['userId'] as String,
    );
  }
}
