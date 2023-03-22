import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart/presentation/views/seller/order/seller_order_details_view.dart';

import '../../../../consts/app_consts.dart';
import 'package:intl/intl.dart' as intl;

import '../../../../models/order_model.dart';
import '../../../../services/firestore_services.dart';

class SellerOrdersView extends StatelessWidget {
  const SellerOrdersView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
              "Orders".text.fontFamily(AppStyles.semiBold).color(AppColors.darkFontGrey).size(18).make(),
              12.heightBox,
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                    stream: FirestoreServices.getSellerOrders(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        List<OrderModel> orders = List.from(
                          snapshot.data!.docs.map(
                            (e) => OrderModel.fromMap(e.data() as Map<String, dynamic>),
                          ),
                        );
                        return ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          itemCount: orders.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              onTap: () {
                                Get.to(() => SellerOrderDetailsView(id: orders[index].id));
                              },
                              tileColor: AppColors.lightGrey,
                              title: orders[index]
                                  .userName
                                  .text
                                  .size(18)
                                  .color(AppColors.darkFontGrey)
                                  .fontFamily(AppStyles.bold)
                                  .make(),
                              subtitle: Column(
                                children: [
                                  Row(
                                    children: [
                                      const Icon(Icons.calendar_month, color: AppColors.darkFontGrey),
                                      12.widthBox,
                                      intl.DateFormat()
                                          .add_yMMMMd()
                                          .format(DateTime.fromMillisecondsSinceEpoch(orders[index].time))
                                          .text
                                          .color(AppColors.darkFontGrey)
                                          .make(),
                                      const Spacer(),
                                      "\$${orders[index].totalPrice}"
                                          .text
                                          .size(16)
                                          .color(AppColors.redColor)
                                          .fontFamily(AppStyles.bold)
                                          .make(),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      const Icon(Icons.payment, color: AppColors.darkFontGrey),
                                      12.widthBox,
                                      (orders[index].paymentMethod == "Cash On Delivery" &&
                                                  orders[index].isDelivered != true
                                              ? "Unpaid"
                                              : "Paid")
                                          .text
                                          .color(orders[index].paymentMethod == "Cash On Delivery" &&
                                                  orders[index].isDelivered != true
                                              ? AppColors.redColor
                                              : Colors.green)
                                          .fontFamily(AppStyles.bold)
                                          .make(),
                                    ],
                                  ),
                                ],
                              ),
                            )
                                .box
                                .white
                                .shadowSm
                                .roundedSM
                                .margin(const EdgeInsets.all(8))
                                .padding(const EdgeInsets.symmetric(vertical: 6))
                                .make();
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
