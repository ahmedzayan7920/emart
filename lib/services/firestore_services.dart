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

  static getCart() {
    return FirebaseFirestore.instance
        .collection(AppFirebase.usersCollection)
        .doc(AppFirebase.currentUser!.uid)
        .collection(AppFirebase.cartCollection)
        .snapshots();
  }

  static deleteCartItem({required String id}) {
    return FirebaseFirestore.instance
        .collection(AppFirebase.usersCollection)
        .doc(AppFirebase.currentUser!.uid)
        .collection(AppFirebase.cartCollection)
        .doc(id)
        .delete();
  }

  static getChat({required String id}) {
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
    return await FirebaseFirestore.instance
        .collection(AppFirebase.productsCollection)
        .doc(id)
        .get();
  }
}
