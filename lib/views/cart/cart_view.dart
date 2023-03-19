import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart/controllers/cart_controller.dart';
import 'package:emart/models/test_model.dart';
import 'package:emart/services/firestore_services.dart';
import 'package:emart/views/cart/shipping_info_view.dart';
import 'package:emart/views/common/custom_button.dart';

import '../../consts/app_consts.dart';

class CartView extends StatelessWidget {
  const CartView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(CartController());
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          children: [
            AppBar(
              title: AppStrings.cart.text.color(AppColors.darkFontGrey).fontFamily(AppStyles.semiBold).make(),
            ),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                  stream: FirestoreServices.getCart(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List<TestModel> cartItems = List.from(
                        snapshot.data!.docs.map(
                          (e) => TestModel.fromMap(e.data() as Map<String, dynamic>),
                        ),
                      );
                      controller.calculateTotalPrice(items: cartItems);
                      return Column(
                        children: [
                          Expanded(
                            child: cartItems.isNotEmpty
                                ? ListView.builder(
                                    physics: const BouncingScrollPhysics(),
                                    itemCount: cartItems.length,
                                    itemBuilder: (context, index) {
                                      return Row(
                                        children: [
                                          CachedNetworkImage(
                                            imageUrl: cartItems[index].product.images.first,
                                            fit: BoxFit.cover,
                                            width: 80,
                                            height: 80,
                                          ),
                                          16.widthBox,
                                          Expanded(
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                cartItems[index].product.name.text.size(16).make(),
                                                12.heightBox,
                                                "\$${cartItems[index].totalPrice}  (${cartItems[index].quantity})"
                                                    .text
                                                    .color(AppColors.redColor)
                                                    .make(),
                                              ],
                                            ),
                                          ),
                                          IconButton(
                                            onPressed: () {
                                              FirestoreServices.deleteCartItem(
                                                  id: cartItems[index].product.id);
                                            },
                                            icon: const Icon(Icons.delete),
                                            color: AppColors.redColor,
                                          ),
                                        ],
                                      ).box.roundedSM.shadowSm.color(AppColors.whiteColor).clip(Clip.antiAlias).make();
                                    },
                                  )
                                : "Cart is Empty!"
                                    .text
                                    .fontFamily(AppStyles.semiBold)
                                    .color(AppColors.darkFontGrey)
                                    .makeCentered(),
                          ),
                          10.heightBox,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              "Total Price"
                                  .text
                                  .color(AppColors.darkFontGrey)
                                  .fontFamily(AppStyles.semiBold)
                                  .make(),
                              "\$${controller.totalPrice}"
                                  .text
                                  .color(AppColors.redColor)
                                  .fontFamily(AppStyles.semiBold)
                                  .make(),
                            ],
                          ).box.color(AppColors.lightGolden).padding(const EdgeInsets.all(12)).make(),
                        ],
                      );
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  }),
            ),
            CustomButton(
              onPressed: () {
                Get.to(()=> const ShippingInfoView());
              },
              text: "Proceed",
            ),
          ],
        ),
      ),
    );
  }
}
