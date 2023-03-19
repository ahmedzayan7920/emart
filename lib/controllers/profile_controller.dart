import 'dart:io';

import 'package:emart/consts/app_consts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class ProfileController extends GetxController {
  var profileImagePath = "".obs;
  var profileImageUrL = "";

  final nameController = TextEditingController();
  final oldPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();

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

  updateProfile({required BuildContext context}) async {
    isLoading(true);
    try {
      if (newPasswordController.text.isNotEmpty && oldPasswordController.text.isNotEmpty) {
        var credential = EmailAuthProvider.credential(
          email: AppFirebase.currentUser!.email!,
          password: oldPasswordController.text,
        );
        await AppFirebase.currentUser!.reauthenticateWithCredential(credential);
        await AppFirebase.currentUser!.updatePassword(newPasswordController.text);
      }
      if (profileImagePath.isNotEmpty) {
        await uploadProfileImage();
        await AppFirebase.firestore
            .collection(AppFirebase.usersCollection)
            .doc(AppFirebase.currentUser!.uid)
            .update({
          "name": nameController.text,
          "profileUrl": profileImageUrL,
        });
      } else {
        await AppFirebase.firestore
            .collection(AppFirebase.usersCollection)
            .doc(AppFirebase.currentUser!.uid)
            .update({
          "name": nameController.text,
        });
      }
      isLoading(false);
      Get.back();
    } on FirebaseAuthException catch (error) {
      print(error.message);
      VxToast.show(context, msg: error.message ?? error.toString());
    } on FirebaseException catch (error) {
      VxToast.show(context, msg: error.message ?? error.toString());
    }
    isLoading(false);
  }
}
