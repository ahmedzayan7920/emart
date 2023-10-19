import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart/models/order_model.dart';

import '../../../../consts/app_consts.dart';
import '../../../../services/firestore_services.dart';
import 'order_details_view.dart';

class OrdersView extends StatelessWidget {
  const OrdersView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: "Orders".text.color(AppColors.darkFontGrey).fontFamily(AppStyles.semiBold).make(),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: StreamBuilder<QuerySnapshot>(
            stream: FirestoreServices.getUserOrders(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<OrderModel> orders = List.from(
                  snapshot.data!.docs.map(
                    (e) => OrderModel.fromMap(e.data() as Map<String, dynamic>),
                  ),
                );
                return ListView.separated(
                  itemCount: orders.length,
                  separatorBuilder: (context, index) => 10.heightBox,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Get.to(()=> OrderDetailsView(order: orders[index]));
                      },
                      child: Row(
                        children: [
                          CachedNetworkImage(
                            imageUrl: orders[index].product.images.first,
                            fit: BoxFit.fill,
                            height: 100,
                            width: 100,
                          ),
                          10.widthBox,
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                "${orders[index].product.name}  (${orders[index].quantity})"
                                    .text
                                    .size(16)
                                    .fontFamily(AppStyles.semiBold)
                                    .color(AppColors.darkFontGrey)
                                    .make(),
                                10.heightBox,
                                Row(
                                  children: [
                                    "Color: "
                                        .text
                                        .size(16)
                                        .fontFamily(AppStyles.semiBold)
                                        .color(AppColors.darkFontGrey)
                                        .make(),
                                    VxBox()
                                        .size(30, 15)
                                        .color(Color(orders[index].color))
                                        .margin(const EdgeInsets.symmetric(horizontal: 4))
                                        .make(),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          10.widthBox,
                          "EGP ${orders[index].totalPrice}"
                              .text
                              .size(16)
                              .fontFamily(AppStyles.semiBold)
                              .color(AppColors.redColor)
                              .make(),
                          10.widthBox,
                        ],
                      ).box.white.shadowSm.roundedSM.clip(Clip.antiAlias).make(),
                    );
                  },
                );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            }),
      ),
    );
  }
}
