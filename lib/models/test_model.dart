import 'package:emart/models/product_model.dart';

class TestModel {
  final ProductModel product;
  final num quantity;
  final num totalPrice;
  final num color;

  TestModel({
    required this.product,
    required this.quantity,
    required this.totalPrice,
    required this.color,
  });

  Map<String, dynamic> toMap() {
    return {
      'product': product.toMap(),
      'quantity': quantity,
      'totalPrice': totalPrice,
      'color': color,
    };
  }

  factory TestModel.fromMap(Map<String, dynamic> map) {
    return TestModel(
      product: ProductModel.fromMap(map['product']),
      quantity: map['quantity'] as num,
      totalPrice: map['totalPrice'] as num,
      color: map['color'] as num,
    );
  }
}
