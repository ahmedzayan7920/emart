import 'package:emart/models/message_model.dart';

import '../consts/app_consts.dart';

class ChatController extends GetxController {
  sendMessage({required MessageModel message}) async {
    await AppFirebase.firestore
        .collection(AppFirebase.usersCollection)
        .doc(AppFirebase.currentUser!.uid)
        .collection(AppFirebase.chatsCollection)
        .doc(message.receiverId)
        .collection(AppFirebase.messagesCollection)
        .doc()
        .set(message.toMap());

    await AppFirebase.firestore
        .collection(AppFirebase.usersCollection)
        .doc(message.receiverId)
        .collection(AppFirebase.chatsCollection)
        .doc(AppFirebase.currentUser!.uid)
        .collection(AppFirebase.messagesCollection)
        .doc()
        .set(message.toMap());

    await AppFirebase.firestore
        .collection(AppFirebase.usersCollection)
        .doc(AppFirebase.currentUser!.uid)
        .collection(AppFirebase.chatsCollection)
        .doc(message.receiverId).set(message.toMap());

    await AppFirebase.firestore
        .collection(AppFirebase.usersCollection)
        .doc(message.receiverId)
        .collection(AppFirebase.chatsCollection)
        .doc(AppFirebase.currentUser!.uid).set(message.toMap());
  }
}
