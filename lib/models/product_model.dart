class ProductModel {
  final String id;
  final String name;
  final String category;
  final String subCategory;
  final String description;
  final num price;
  final num rating;
  final num quantity;
  final List<num> colors;
  final List<String> images;
  final List<String> wishlist;
  final String seller;
  final String sellerId;

  ProductModel({
    required this.id,
    required this.name,
    required this.category,
    required this.subCategory,
    required this.description,
    required this.price,
    required this.rating,
    required this.quantity,
    required this.colors,
    required this.images,
    required this.wishlist,
    required this.seller,
    required this.sellerId,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'category': category,
      'subCategory': subCategory,
      'description': description,
      'price': price,
      'rating': rating,
      'quantity': quantity,
      'colors': colors,
      'images': images,
      'wishlist': wishlist,
      'seller': seller,
      'sellerId': sellerId,
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      id: map['id'] as String,
      name: map['name'] as String,
      category: map['category'] as String,
      subCategory: map['subCategory'] as String,
      description: map['description'] as String,
      price: map['price'] as num,
      rating: map['rating'] as num,
      quantity: map['quantity'] as num,
      colors: (map['colors'] as List).map((e) => e as num).toList(),
      images: (map['images'] as List).map((dynamic e) => e as String).toList(),
      wishlist: (map['wishlist'] as List).map((e) => e as String).toList(),
      seller: map['seller'] as String,
      sellerId: map['sellerId'] as String,
    );
  }
}
