import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart/controllers/auth_controller.dart';
import 'package:emart/models/user_model.dart';
import 'package:emart/views/common/custom_background.dart';
import 'package:emart/views/orders/orders_view.dart';
import 'package:emart/presentation/views/common/edit_profile_view.dart';
import 'package:emart/views/profile/wishlist_view.dart';

import '../../consts/app_consts.dart';
import '../../presentation/views/common/chat/chat_view.dart';
import '../../services/firestore_services.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomBackground(
      child: SafeArea(
        child: Container(
          height: double.infinity,
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          child: StreamBuilder<QuerySnapshot>(
            stream: FirestoreServices.getUser(uid: AppFirebase.currentUser!.uid),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                UserModel user = UserModel.fromMap(snapshot.data!.docs.first.data() as Map<String, dynamic>);
                return Column(
                  children: [
                    Row(
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
                              user.name.text.white.fontFamily(AppStyles.semiBold).make(),
                              user.email.text.white.fontFamily(AppStyles.semiBold).make(),
                            ],
                          ),
                        ),
                        OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: Colors.white),
                          ),
                          onPressed: () {
                            Get.put(AuthController()).logout(context: context);
                          },
                          child: "Logout".text.fontFamily(AppStyles.semiBold).white.make(),
                        ),
                      ],
                    ),
                    15.heightBox,
                    Column(
                      children: [
                        ListTile(
                          onTap: () {
                            Get.to(() => EditProfileView(userModel: user));
                          },
                          leading: Image.asset(AppImages.icEdit, height: 22, color: AppColors.darkFontGrey),
                          title: "Edit Profile"
                              .text
                              .color(AppColors.darkFontGrey)
                              .fontFamily(AppStyles.semiBold)
                              .make(),
                        ),
                        const Divider(color: AppColors.lightGrey, thickness: 1.5, indent: 10, endIndent: 10),
                        ListTile(
                          onTap: () {
                            Get.to(()=> const OrdersView());
                          },
                          leading: Image.asset(AppImages.icOrders, height: 22, color: AppColors.darkFontGrey),
                          title: "My Orders"
                              .text
                              .color(AppColors.darkFontGrey)
                              .fontFamily(AppStyles.semiBold)
                              .make(),
                        ),
                        const Divider(color: AppColors.lightGrey, thickness: 1.5, indent: 10, endIndent: 10),
                        ListTile(
                          onTap: () {
                            Get.to(()=> const WishlistView());
                          },
                          leading: Image.asset(AppImages.icHeart, height: 22, color: AppColors.darkFontGrey),
                          title: "My Wishlist"
                              .text
                              .color(AppColors.darkFontGrey)
                              .fontFamily(AppStyles.semiBold)
                              .make(),
                        ),
                        const Divider(color: AppColors.lightGrey, thickness: 1.5, indent: 10, endIndent: 10),
                        ListTile(
                          onTap: () {
                            Get.to(()=> const ChatsView());
                          },
                          leading:
                              Image.asset(AppImages.icMessages, height: 22, color: AppColors.darkFontGrey),
                          title: "Chats"
                              .text
                              .color(AppColors.darkFontGrey)
                              .fontFamily(AppStyles.semiBold)
                              .make(),
                        ),
                      ],
                    )
                        .box
                        .white
                        .rounded
                        .shadow
                        .padding(const EdgeInsets.symmetric(horizontal: 10))
                        .margin(const EdgeInsets.symmetric(horizontal: 8))
                        .make(),
                  ],
                );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
        ),
      ),
    );
  }
}
