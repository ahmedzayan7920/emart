import 'package:emart/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../consts/app_consts.dart';

class AuthController extends GetxController {
  var isLoading = false.obs;
  var isUser = true.obs;
  var isTermsAgreed = false.obs;

  Future login({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    isLoading(true);
    try {
      UserCredential userCredential =
          await AppFirebase.auth.signInWithEmailAndPassword(email: email, password: password);
      AppFirebase.currentUser = userCredential.user;
    } on FirebaseAuthException catch (error) {
      isLoading(false);
      VxToast.show(context, msg: error.message ?? error.toString());
    }

  }

  Future signUp({
    required String name,
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    isLoading(true);
    try {
      UserCredential userCredential =
          await AppFirebase.auth.createUserWithEmailAndPassword(email: email, password: password);
      AppFirebase.currentUser = userCredential.user;
      await userCredential.user?.updateDisplayName(name);
      await userCredential.user?.reload();
      AppFirebase.currentUser = FirebaseAuth.instance.currentUser;
      await storeUserData();
    } on FirebaseAuthException catch (error) {
      isLoading(false);
      VxToast.show(context, msg: error.message ?? error.toString());
    }

  }

  Future storeUserData() async {
    try {
      UserModel userModel = UserModel(
        uid: AppFirebase.currentUser!.uid,
        name: AppFirebase.currentUser!.displayName!,
        email: AppFirebase.currentUser!.email!,
        profileUrl: "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png",
        isUser: isUser.value,
      );
      await AppFirebase.firestore
          .collection(AppFirebase.usersCollection)
          .doc(AppFirebase.currentUser!.uid)
          .set(userModel.toMap());
    } catch (error) {
      await AppFirebase.currentUser!.delete();
      rethrow;
    }
  }

  Future logout({
    required BuildContext context,
  }) async {
    try {
      await AppFirebase.auth.signOut();
    } on FirebaseAuthException catch (error) {
      VxToast.show(context, msg: error.message ?? error.toString());
    }
  }
}
