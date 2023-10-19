// ignore_for_file: use_build_context_synchronously

import 'package:emart/models/message_model.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../consts/app_consts.dart';

class ChatController extends GetxController {
  sendMessage({required MessageModel message, required BuildContext context}) async {
    if (await InternetConnectionChecker().hasConnection) {
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
          .doc(message.receiverId)
          .set(message.toMap());

      await AppFirebase.firestore
          .collection(AppFirebase.usersCollection)
          .doc(message.receiverId)
          .collection(AppFirebase.chatsCollection)
          .doc(AppFirebase.currentUser!.uid)
          .set(message.toMap());
    } else {
      VxToast.show(context, msg: "No Internet Connection");
    }
  }
}
