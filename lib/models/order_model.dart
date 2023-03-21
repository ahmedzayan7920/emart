import 'package:emart/models/product_model.dart';

import 'address_model.dart';

class OrderModel {
  final String id;
  final ProductModel product;
  final int quantity;
  final num productPrice;
  final num shippingPrice;
  final num totalPrice;
  final int color;
  final int time;
  final String userId;
  final String userName;
  final String sellerId;
  final String paymentMethod;
  final bool isPlaced;
  final bool isConfirmed;
  final bool isOnDelivery;
  final bool isDelivered;
  final AddressModel address;

  OrderModel({
    required this.id,
    required this.product,
    required this.quantity,
    required this.productPrice,
    required this.shippingPrice,
    required this.totalPrice,
    required this.color,
    required this.time,
    required this.userId,
    required this.userName,
    required this.sellerId,
    required this.paymentMethod,
    required this.isPlaced,
    required this.isConfirmed,
    required this.isOnDelivery,
    required this.isDelivered,
    required this.address,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'product': product.toMap(),
      'quantity': quantity,
      'productPrice': productPrice,
      'shippingPrice': shippingPrice,
      'totalPrice': totalPrice,
      'color': color,
      'time': time,
      'userId': userId,
      'userName': userName,
      'sellerId': sellerId,
      'paymentMethod': paymentMethod,
      'isPlaced': isPlaced,
      'isConfirmed': isConfirmed,
      'isOnDelivery': isOnDelivery,
      'isDelivered': isDelivered,
      'address': address.toMap(),
    };
  }

  factory OrderModel.fromMap(Map<String, dynamic> map) {
    return OrderModel(
      id: map['id'] as String,
      product: ProductModel.fromMap(map['product']),
      quantity: map['quantity'] as int,
      productPrice: map['productPrice'] as num,
      shippingPrice: map['shippingPrice'] as num,
      totalPrice: map['totalPrice'] as num,
      color: map['color'] as int,
      time: map['time'] as int,
      userId: map['userId'] as String,
      userName: map['userName'] as String,
      sellerId: map['sellerId'] as String,
      paymentMethod: map['paymentMethod'] as String,
      isPlaced: map['isPlaced'] as bool,
      isConfirmed: map['isConfirmed'] as bool,
      isOnDelivery: map['isOnDelivery'] as bool,
      isDelivered: map['isDelivered'] as bool,
      address: AddressModel.fromMap(map['address']),
    );
  }
}
