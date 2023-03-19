import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:emart/controllers/profile_controller.dart';
import 'package:emart/views/common/custom_background.dart';
import 'package:emart/views/common/custom_button.dart';
import 'package:emart/views/common/custom_text_field.dart';

import '../../consts/app_consts.dart';
import '../../models/user_model.dart';

class EditProfileView extends StatefulWidget {
  const EditProfileView({Key? key, required this.userModel}) : super(key: key);

  final UserModel userModel;

  @override
  State<EditProfileView> createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView> {
  final controller = Get.put(ProfileController());

  @override
  void initState() {
    controller.nameController.text = widget.userModel.name;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomBackground(
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                Obx(
                  () => Stack(
                    children: [
                      (controller.profileImagePath.isEmpty
                              ? CachedNetworkImage(
                                  imageUrl: widget.userModel.profileUrl,
                                  fit: BoxFit.cover,
                                )
                              : Image.file(
                                  File(controller.profileImagePath.value),
                                  fit: BoxFit.cover,
                                ))
                          .box
                          .width(120)
                          .height(120)
                          .color(AppColors.lightGrey)
                          .roundedFull
                          .clip(Clip.antiAlias)
                          .make(),
                      PositionedDirectional(
                        bottom: 0,
                        end: 10,
                        child: CircleAvatar(
                          radius: 18,
                          backgroundColor: AppColors.redColor,
                          child: IconButton(
                            onPressed: () {
                              controller.pickProfileImage();
                            },
                            icon: const Icon(Icons.edit),
                            padding: EdgeInsets.zero,
                            color: AppColors.whiteColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                10.heightBox,
                CustomTextField(
                  title: AppStrings.name,
                  hint: AppStrings.nameHint,
                  controller: controller.nameController,
                ),
                CustomTextField(
                  title: AppStrings.password,
                  hint: AppStrings.passwordHint,
                  controller: controller.oldPasswordController,
                  isPassword: true,
                ),
                CustomTextField(
                  title: AppStrings.password,
                  hint: AppStrings.passwordHint,
                  controller: controller.newPasswordController,
                  isPassword: true,
                ),
                20.heightBox,
                Obx(
                  () => controller.isLoading.value
                      ? const Center(child: CircularProgressIndicator())
                      : CustomButton(
                          onPressed: () {
                            controller.updateProfile(context: context);
                          },
                          text: "Save",
                        ),
                ),
              ],
            )
                .box
                .white
                .roundedSM
                .shadowSm
                .margin(const EdgeInsets.only(bottom: 50, right: 16, left: 16))
                .padding(const EdgeInsets.all(16))
                .makeCentered(),
          ),
        ),
      ),
    );
  }
}
