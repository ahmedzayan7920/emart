import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart/models/product_model.dart';
import 'package:emart/presentation/views/seller/product/seller_edit_product_view.dart';
import 'package:emart/presentation/views/seller/product/seller_product_details_view.dart';

import '../../../../consts/app_consts.dart';
import '../../../../controllers/seller_product_controller.dart';
import '../../../../services/firestore_services.dart';

class SellerProductsView extends StatelessWidget {
  const SellerProductsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(SellerProductController());
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.white,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              "Products".text.fontFamily(AppStyles.semiBold).color(AppColors.darkFontGrey).size(18).make(),
              12.heightBox,
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                    stream: FirestoreServices.getSellerProducts(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        List<ProductModel> products = List.from(
                          snapshot.data!.docs.map(
                            (e) => ProductModel.fromMap(e.data() as Map<String, dynamic>),
                          ),
                        );
                        return ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          itemCount: products.length,
                          itemBuilder: (context, index) {
                            return Row(
                              children: [
                                CachedNetworkImage(
                                  imageUrl: products[index].images.first,
                                  height: 80,
                                  width: 100,
                                  fit: BoxFit.cover,
                                ),
                                12.widthBox,
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      products[index]
                                          .name
                                          .text
                                          .size(18)
                                          .fontFamily(AppStyles.semiBold)
                                          .make(),
                                      10.heightBox,
                                      Row(
                                        children: [
                                          "\$${products[index].price}"
                                              .text
                                              .size(16)
                                              .fontFamily(AppStyles.semiBold)
                                              .color(AppColors.redColor)
                                              .make(),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                products[index].isFeatured
                                    ? "Featured".text.size(16).color(Colors.green).make()
                                    : const SizedBox.shrink(),
                                VxPopupMenu(
                                  menuBuilder: () {
                                    return Column(
                                      children: [
                                        Row(
                                          children: [
                                            const Icon(Icons.featured_play_list_outlined,
                                                color: AppColors.darkFontGrey),
                                            10.widthBox,
                                            (products[index].isFeatured ? "Remove Featured" : "Make Featured")
                                                .text
                                                .color(AppColors.darkFontGrey)
                                                .make(),
                                          ],
                                        ).onInkTap(() {
                                          controller.changeFeaturedStatus(
                                            id: products[index].id,
                                            isFeatured: products[index].isFeatured,
                                          );
                                          controller.menuController.hideMenu();
                                        }),
                                        10.heightBox,
                                        Row(
                                          children: [
                                            const Icon(Icons.edit_outlined, color: AppColors.darkFontGrey),
                                            10.widthBox,
                                            "Edit".text.color(AppColors.darkFontGrey).make(),
                                          ],
                                        ).onInkTap(() {
                                          Get.to(() => SellerEditProductView(product: products[index]));
                                          controller.menuController.hideMenu();
                                        }),
                                        10.heightBox,
                                        Row(
                                          children: [
                                            const Icon(Icons.delete_outline, color: AppColors.darkFontGrey),
                                            10.widthBox,
                                            "Delete".text.color(AppColors.darkFontGrey).make(),
                                          ],
                                        ).onInkTap(() {
                                          controller.deleteProduct(product: products[index]);
                                          controller.menuController.hideMenu();
                                        }),
                                      ],
                                    ).box.white.roundedSM.width(200).padding(const EdgeInsets.all(8)).make();
                                  },
                                  clickType: VxClickType.singleClick,
                                  arrowSize: 0,
                                  controller: controller.menuController,
                                  child: const Icon(Icons.more_vert_rounded),
                                ),
                                10.widthBox,
                              ],
                            )
                                .box
                                .white
                                .roundedSM
                                .shadowSm
                                .clip(Clip.antiAlias)
                                .margin(const EdgeInsets.all(8))
                                .make()
                                .onInkTap(() {
                              Get.to(() => SellerProductDetailsView(product: products[index]));
                            });
                          },
                        );
                      } else {
                        return const Center(child: CircularProgressIndicator());
                      }
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
