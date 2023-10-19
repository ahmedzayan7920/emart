// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:emart/consts/app_consts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class ProfileController extends GetxController {
  var profileImagePath = "".obs;
  var profileImageUrL = "";

  var isLoading = false.obs;

  pickProfileImage() async {
    final pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery, imageQuality: 70);
    if (pickedImage == null) return;
    profileImagePath(pickedImage.path);
  }

  uploadProfileImage() async {
    final ref = FirebaseStorage.instance.ref("profileImages").child(AppFirebase.currentUser!.uid);
    await ref.putFile(File(profileImagePath.value));
    profileImageUrL = await ref.getDownloadURL();
  }

  updateProfile({
    required String name,
    required String oldPassword,
    required String newPassword,
    required BuildContext context,
  }) async {
    isLoading(true);
    if (await InternetConnectionChecker().hasConnection) {
      try {
        if (oldPassword.isNotEmpty || newPassword.isNotEmpty) {
          var credential = EmailAuthProvider.credential(
            email: AppFirebase.currentUser!.email!,
            password: oldPassword,
          );
          await AppFirebase.currentUser!.reauthenticateWithCredential(credential);
          await AppFirebase.currentUser!.updatePassword(newPassword);
        }
        if (profileImagePath.isNotEmpty) {
          await uploadProfileImage();
          await AppFirebase.firestore
              .collection(AppFirebase.usersCollection)
              .doc(AppFirebase.currentUser!.uid)
              .update({
            "name": name,
            "profileUrl": profileImageUrL,
          });
        } else {
          await AppFirebase.firestore
              .collection(AppFirebase.usersCollection)
              .doc(AppFirebase.currentUser!.uid)
              .update({
            "name": name,
          });
        }
        Get.back();
      } on FirebaseAuthException catch (error) {
        VxToast.show(context, msg: error.message ?? error.toString());
      } on FirebaseException catch (error) {
        VxToast.show(context, msg: error.message ?? error.toString());
      }
    } else {
      VxToast.show(context, msg: "No Internet Connection");
    }
    isLoading(false);
  }
}
