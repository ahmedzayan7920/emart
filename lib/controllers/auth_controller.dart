import 'package:emart/models/user_model.dart';
import 'package:emart/views/auth/login_view.dart';
import 'package:emart/views/main/main_view.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../consts/app_consts.dart';

class AuthController extends GetxController {
  var isLoading = false.obs;

  Future login({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      UserCredential userCredential =
          await AppFirebase.auth.signInWithEmailAndPassword(email: email, password: password);
      AppFirebase.currentUser = userCredential.user;
      Get.offAll(() => const MainView());
    } on FirebaseAuthException catch (error) {
      VxToast.show(context, msg: error.message ?? error.toString());
    }
    isLoading(false);
  }

  Future signUp({
    required String name,
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      UserCredential userCredential =
          await AppFirebase.auth.createUserWithEmailAndPassword(email: email, password: password);
      AppFirebase.currentUser = userCredential.user;
      UserModel userModel = UserModel(
        uid: userCredential.user!.uid,
        name: name,
        email: email,
        profileUrl: "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png",
        isAdmin: false,
        cartCount: 0,
        orderCount: 0,
        wishlistCount: 0,
      );
      await storeUserData(userModel: userModel);
      Get.offAll(() => const MainView());
    } on FirebaseAuthException catch (error) {
      VxToast.show(context, msg: error.message ?? error.toString());
      await logout(context: context);
    }
  }

  Future storeUserData({
    required UserModel userModel,
  }) async {
    try {
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
      Get.offAll(() => const LoginView());
    } on FirebaseAuthException catch (error) {
      VxToast.show(context, msg: error.message ?? error.toString());
    }
  }
}
