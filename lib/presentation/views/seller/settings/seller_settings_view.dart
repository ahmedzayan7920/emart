import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart/views/common/custom_background.dart';

import '../../../../consts/app_consts.dart';
import '../../../../controllers/auth_controller.dart';
import '../../../../models/user_model.dart';
import '../../../../services/firestore_services.dart';
import '../../common/chat/chat_view.dart';
import '../../common/edit_profile_view.dart';

class SellerSettingsView extends StatelessWidget {
  const SellerSettingsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomBackground(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              StreamBuilder<QuerySnapshot>(
                stream: FirestoreServices.getUser(uid: AppFirebase.currentUser!.uid),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    UserModel user =
                        UserModel.fromMap(snapshot.data!.docs.first.data() as Map<String, dynamic>);
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CachedNetworkImage(
                          imageUrl: user.profileUrl,
                          fit: BoxFit.cover,
                        )
                            .box
                            .width(70)
                            .height(70)
                            .color(AppColors.lightGrey)
                            .roundedFull
                            .clip(Clip.antiAlias)
                            .make(),
                        10.widthBox,
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              user.name.text
                                  .size(16)
                                  .white
                                  .fontFamily(AppStyles.semiBold)
                                  .make(),
                              user.email.text
                                  .white
                                  .fontFamily(AppStyles.semiBold)
                                  .make(),
                            ],
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            Get.to(() => EditProfileView(userModel: user));
                          },
                          icon: const Icon(Icons.edit_outlined),
                          color: Colors.white,
                        ),
                      ],
                    ).box.rounded.padding(const EdgeInsets.all(12)).border(color: Colors.white, width: 2).make();
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              ),
              15.heightBox,
              Column(
                children: [
                  ListTile(
                    onTap: () {
                      Get.to(()=> const ChatsView());
                    },
                    leading: Image.asset(AppImages.icMessages, height: 22, color: AppColors.darkFontGrey),
                    title: "Chats".text.color(AppColors.darkFontGrey).fontFamily(AppStyles.semiBold).make(),
                  ),
                  const Divider(color: AppColors.lightGrey, thickness: 1.5, indent: 10, endIndent: 10),
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: AppColors.darkFontGrey),
                    ),
                    onPressed: () {
                      Get.put(AuthController()).logout(context: context);
                    },
                    child: "Logout".text.fontFamily(AppStyles.semiBold).color(AppColors.darkFontGrey).make(),
                  ),
                ],
              )
                  .box
                  .white
                  .rounded
                  .shadow
                  .padding(const EdgeInsets.all( 10))
                  .margin(const EdgeInsets.symmetric(horizontal: 8))
                  .make(),
            ],
          ),
        ),
      ),
    );
  }
}
