import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart/consts/app_consts.dart';
import 'package:emart/models/test_model.dart';

import '../models/product_model.dart';
import '../services/firestore_services.dart';

class ProductController extends GetxController {

  var quantity = 1.obs;
  var selectedColorIndex = 0.obs;
  var totalPrice = 0.0.obs;

  var isFavorite = false.obs;

  increaseQuantity({required ProductModel product}) {
    if (quantity.value < product.quantity) {
      quantity.value++;
      calculateTotalPrice(product.price);
    } else {
      return null;
    }
  }

  decreaseQuantity({required ProductModel product}) {
    if (quantity.value > 1) {
      quantity.value--;
      calculateTotalPrice(product.price);
    } else {
      return null;
    }
  }

  calculateTotalPrice(price) {
    totalPrice(double.tryParse((price * quantity.value).toString()));
  }

  addToCart({required ProductModel product}) async {
    TestModel data = TestModel(
      product: product,
      quantity: quantity.value,
      totalPrice: totalPrice.value,
      color: product.colors[selectedColorIndex.value],
    );
    await AppFirebase.firestore
        .collection(AppFirebase.usersCollection)
        .doc(AppFirebase.currentUser!.uid)
        .collection(AppFirebase.cartCollection)
        .doc(product.id)
        .set(data.toMap());
  }

  addToWishlist({required String id}) async {
    if (isFavorite.value) {
      await AppFirebase.firestore.collection(AppFirebase.productsCollection).doc(id).update({
        "wishlist": FieldValue.arrayRemove([AppFirebase.currentUser!.uid]),
      });
      isFavorite.value = false;
    } else {
      await AppFirebase.firestore.collection(AppFirebase.productsCollection).doc(id).update({
        "wishlist": FieldValue.arrayUnion([AppFirebase.currentUser!.uid]),
      });
      isFavorite.value = true;
    }
  }
}
