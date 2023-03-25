// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:emart/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../consts/app_consts.dart';
import '../presentation/views/common/auth/login_view.dart';
import '../presentation/widgets/custom_password_message_dialog.dart';
import '../services/firestore_services.dart';
import '../presentation/views/user/main_view.dart';
import '../presentation/views/seller/seller_main_view.dart';

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
    if (await InternetConnectionChecker().hasConnection) {
      try {
        UserCredential userCredential =
            await AppFirebase.auth.signInWithEmailAndPassword(email: email, password: password);
        AppFirebase.currentUser = userCredential.user;
        final DocumentSnapshot<Map<String, dynamic>> data =
            await FirestoreServices.getUserRole(id: AppFirebase.currentUser!.uid);
        if (data.data()!["isUser"].toString() == "true") {
          Get.offAll(() => const MainView());
        } else {
          Get.offAll(() => const SellerMainView());
        }
      } on FirebaseAuthException catch (error) {
        VxToast.show(context, msg: error.message ?? error.toString());
      }
    } else {
      VxToast.show(context, msg: "No Internet Connection");
    }
    isLoading(false);
  }

  Future signUp({
    required String name,
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    isLoading(true);
    if (await InternetConnectionChecker().hasConnection) {
      try {
        UserCredential userCredential =
            await AppFirebase.auth.createUserWithEmailAndPassword(email: email, password: password);
        AppFirebase.currentUser = userCredential.user;
        await userCredential.user?.updateDisplayName(name);
        await userCredential.user?.reload();
        AppFirebase.currentUser = FirebaseAuth.instance.currentUser;
        await storeUserData();
        if (isUser.value) {
          Get.offAll(() => const MainView());
        } else {
          Get.offAll(() => const SellerMainView());
        }
      } on FirebaseAuthException catch (error) {
        VxToast.show(context, msg: error.message ?? error.toString());
      }
    } else {
      VxToast.show(context, msg: "No Internet Connection");
    }
    isLoading(false);
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
      Get.offAll(() => const LoginView());
    } on FirebaseAuthException catch (error) {
      VxToast.show(context, msg: error.message ?? error.toString());
    }
  }

  resetPassword({required BuildContext context, required String email}) async {
    isLoading(true);
    if (await InternetConnectionChecker().hasConnection) {
      try {
        await AppFirebase.auth.sendPasswordResetEmail(email: email);
        showDialog(
          context: context,
          builder: (context) => const CustomPasswordMessageDialog(),
        );
      } on FirebaseAuthException catch (error) {
        VxToast.show(context, msg: error.message ?? error.toString());
      }
    } else {
      VxToast.show(context, msg: "No Internet Connection");
    }
    isLoading(false);
  }
}
