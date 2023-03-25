// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart/consts/app_consts.dart';
import 'package:emart/models/address_model.dart';
import 'package:emart/models/order_model.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../models/product_model.dart';
import '../presentation/views/user/orders/orders_view.dart';

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

  addToWishlist({required String id, required BuildContext context}) async {
    if (await InternetConnectionChecker().hasConnection) {
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
    } else {
      VxToast.show(context, msg: "No Internet Connection");
    }
  }

  late AddressModel addressModel;

  var isAddingAddress = false.obs;

  saveAddress({
    required String address,
    required String city,
    required String state,
    required String country,
    required String postalCode,
    required String phone,
    required BuildContext context,
  }) async {
    isAddingAddress(true);
    if (await InternetConnectionChecker().hasConnection) {
      final ref = AppFirebase.firestore
          .collection(AppFirebase.usersCollection)
          .doc(AppFirebase.currentUser!.uid)
          .collection(AppFirebase.addressesCollection)
          .doc();
      addressModel = AddressModel(
        id: ref.id,
        address: address,
        city: city,
        state: state,
        country: country,
        postalCode: postalCode,
        phone: phone,
      );

      await ref.set(addressModel.toMap()).then((value) {
        Get.back();
      });
    } else {
      VxToast.show(context, msg: "No Internet Connection");
    }
    isAddingAddress(false);
  }

  var selectedAddressIndex = (-1).obs;

  var selectedPaymentIndex = 0.obs;

  late ProductModel product;

  var isPlacingOrder = false.obs;

  placeMyOrder({required BuildContext context}) async {
    isPlacingOrder(true);
    if (await InternetConnectionChecker().hasConnection) {
      final ref = AppFirebase.firestore.collection(AppFirebase.ordersCollection).doc();
      OrderModel orderModel = OrderModel(
        id: ref.id,
        product: product,
        quantity: quantity.value,
        productPrice: totalPrice.value,
        shippingPrice: product.shippingPrice,
        totalPrice: totalPrice.value + product.shippingPrice,
        color: product.colors[selectedColorIndex.value],
        time: DateTime.now().millisecondsSinceEpoch,
        userId: AppFirebase.currentUser!.uid,
        userName: AppFirebase.currentUser!.displayName ?? "",
        sellerId: product.sellerId,
        paymentMethod: AppLists.paymentTitles[selectedPaymentIndex.value],
        isPlaced: true,
        isConfirmed: false,
        isOnDelivery: false,
        isDelivered: false,
        address: addressModel,
      );

      await ref.set(orderModel.toMap());
      await AppFirebase.firestore
          .collection(AppFirebase.productsCollection)
          .doc(product.id)
          .update({"quantity": FieldValue.increment((quantity.value * -1))});
    } else {
      VxToast.show(context, msg: "No Internet Connection");
    }
    isPlacingOrder(false);
    Get.back();
    Get.back();
    Get.back();
    Get.back();
    Get.to(() => const OrdersView());
  }
}
