import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart/consts/app_consts.dart';

class FirestoreServices {
  static getUser({required String uid}) {
    return FirebaseFirestore.instance
        .collection(AppFirebase.usersCollection)
        .where("uid", isEqualTo: uid)
        .snapshots();
  }

  static getCategoryProducts({required String category}) {
    return FirebaseFirestore.instance
        .collection(AppFirebase.productsCollection)
        .where("category", isEqualTo: category)
        .snapshots();
  }

  static getSubCategoryProducts({required String subCategory}) {
    return FirebaseFirestore.instance
        .collection(AppFirebase.productsCollection)
        .where("subCategory", isEqualTo: subCategory)
        .snapshots();
  }

  static getMessages({required String id}) {
    return FirebaseFirestore.instance
        .collection(AppFirebase.usersCollection)
        .doc(AppFirebase.currentUser!.uid)
        .collection(AppFirebase.chatsCollection)
        .doc(id)
        .collection(AppFirebase.messagesCollection)
        .orderBy("time")
        .snapshots();
  }

  static getProduct({required String id}) async {
    return await FirebaseFirestore.instance.collection(AppFirebase.productsCollection).doc(id).get();
  }

  static getAddresses() {
    return FirebaseFirestore.instance
        .collection(AppFirebase.usersCollection)
        .doc(AppFirebase.currentUser!.uid)
        .collection(AppFirebase.addressesCollection)
        .snapshots();
  }

  static getOrders() {
    return FirebaseFirestore.instance
        .collection(AppFirebase.ordersCollection)
        .where("userId", isEqualTo: AppFirebase.currentUser!.uid)
        .orderBy("time")
        .snapshots();
  }

  static getWishlist() {
    return FirebaseFirestore.instance
        .collection(AppFirebase.productsCollection)
        .where("wishlist", arrayContains: AppFirebase.currentUser!.uid)
        .snapshots();
  }

  static getChats() {
    return FirebaseFirestore.instance
        .collection(AppFirebase.usersCollection)
        .doc(AppFirebase.currentUser!.uid)
        .collection(AppFirebase.chatsCollection)
        .snapshots();
  }

  static getAllProducts() {
    return FirebaseFirestore.instance.collection(AppFirebase.productsCollection).snapshots();
  }

  static getFeaturedProducts() {
    return FirebaseFirestore.instance
        .collection(AppFirebase.productsCollection)
        .where("isFeatured", isEqualTo: true)
        .snapshots();
  }

  static searchForProduct({required String query}) {
    return FirebaseFirestore.instance.collection(AppFirebase.productsCollection).get();
  }

  static getProductsYouMayLike({required String subCategory, required String id}) {
    return FirebaseFirestore.instance
        .collection(AppFirebase.productsCollection)
        .where("subCategory", isEqualTo: subCategory)
        .where("id", isNotEqualTo: id)
        .get();
  }

  static getUserRole({required String id}) {
    return  FirebaseFirestore.instance.collection(AppFirebase.usersCollection).doc(id).get();
  }
}
