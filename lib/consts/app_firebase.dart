import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AppFirebase{
  static FirebaseAuth auth = FirebaseAuth.instance;
  static FirebaseFirestore firestore = FirebaseFirestore.instance;
  static User? currentUser = auth.currentUser;


  static const String usersCollection = "users";
  static const String productsCollection = "products";
  static const String chatsCollection = "chats";
  static const String messagesCollection = "messages";
  static const String addressesCollection = "addresses";
  static const String ordersCollection = "orders";

}