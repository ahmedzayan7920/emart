import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart/controllers/seller_orders_controller.dart';
import 'package:emart/models/order_model.dart';
import 'package:emart/views/common/custom_button.dart';
import 'package:emart/views/orders/widgets/custom_order_status.dart';

import '../../../../consts/app_consts.dart';
import 'package:intl/intl.dart' as intl;

import '../../../../services/firestore_services.dart';
import '../../../../views/orders/widgets/custom_details_row.dart';

class SellerOrderDetailsView extends StatelessWidget {
  const SellerOrderDetailsView({Key? key, required this.id}) : super(key: key);

  final String id;

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(SellerOrdersController());
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: "Order Details".text.color(AppColors.darkFontGrey).fontFamily(AppStyles.semiBold).make(),
      ),
      body: StreamBuilder<DocumentSnapshot>(
          stream: FirestoreServices.getOrder(id: id),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              OrderModel order = OrderModel.fromMap(snapshot.data!.data() as Map<String, dynamic>);
              return Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomOrderStatus(
                            title: "Placed",
                            isDone: order.isPlaced,
                          ),
                          CustomOrderStatus(
                            title: "Confirmed",
                            isDone: order.isConfirmed,
                          ),
                          CustomOrderStatus(
                            title: "On Delivery",
                            isDone: order.isOnDelivery,
                          ),
                          CustomOrderStatus(
                            title: "Delivered",
                            isDone: order.isDelivered,
                          ),
                          Column(
                            children: [
                              CustomDetailsRow(
                                title1: "Order Date",
                                detail1: intl.DateFormat("MMM d hh:mm a")
                                    .format(DateTime.fromMillisecondsSinceEpoch(order.time)),
                                title2: "Payment Method",
                                detail2: order.paymentMethod,
                                color1: AppColors.redColor,
                              ),
                              18.heightBox,
                              CustomDetailsRow(
                                title1: "Payment Status",
                                detail1:
                                    order.paymentMethod == "Cash On Delivery" && order.isDelivered != true
                                        ? "Unpaid"
                                        : "Paid",
                                title2: "Delivery Status",
                                detail2: order.isDelivered
                                    ? "Order Delivered"
                                    : order.isOnDelivery
                                        ? "Order On Delivery"
                                        : order.isConfirmed
                                            ? "Order Confirmed"
                                            : "Order Placed",
                                color1: AppColors.redColor,
                              ),
                              18.heightBox,
                              CustomDetailsRow(
                                title1: "Product Price",
                                detail1: "\$${order.productPrice}",
                                title2: "Shipping Price",
                                detail2: "\$${order.shippingPrice}",
                                color1: AppColors.redColor,
                                color2: AppColors.redColor,
                              ),
                              18.heightBox,
                              CustomDetailsRow(
                                title1: "Shipping Address",
                                detail1:
                                    "${order.address.address}\n${order.address.city}\n${order.address.state}\n${order.address.country}\n${order.address.postalCode}\n${order.address.phone}",
                                title2: "Total Amount",
                                detail2: "\$${order.totalPrice}",
                                color2: AppColors.redColor,
                              ),
                            ],
                          )
                              .box
                              .white
                              .roundedSM
                              .shadowSm
                              .margin(const EdgeInsets.all(16))
                              .padding(const EdgeInsets.all(12))
                              .make(),
                          "Ordered Product"
                              .text
                              .size(18)
                              .fontFamily(AppStyles.semiBold)
                              .color(AppColors.darkFontGrey)
                              .make()
                              .box
                              .margin(const EdgeInsets.symmetric(horizontal: 16))
                              .make(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  order.product.name.text
                                      .size(16)
                                      .fontFamily(AppStyles.semiBold)
                                      .color(AppColors.darkFontGrey)
                                      .make(),
                                  "${order.quantity}x".text.color(AppColors.redColor).make(),
                                  VxBox().size(30, 15).color(Color(order.color)).make(),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  "\$${order.productPrice}"
                                      .text
                                      .size(16)
                                      .fontFamily(AppStyles.semiBold)
                                      .color(AppColors.redColor)
                                      .make(),
                                  "Refundable".text.make(),
                                ],
                              ),
                            ],
                          ).box.margin(const EdgeInsets.all(16)).make(),
                        ],
                      ),
                    ),
                  ),
                  order.isDelivered
                      ? const SizedBox.shrink()
                      : Obx(
                          () => controller.isLoading.value
                              ? const Center(child: CircularProgressIndicator())
                              : CustomButton(
                                  onPressed: () {
                                    controller.changeOrderStatus(
                                      id: order.id,
                                      status: !(order.isConfirmed)
                                          ? "isConfirmed"
                                          : !(order.isOnDelivery)
                                              ? "isOnDelivery"
                                              : "isDelivered",
                                    );
                                  },
                                  text: !(order.isConfirmed)
                                      ? "Confirm Order"
                                      : !(order.isOnDelivery)
                                          ? "Send Order"
                                          : "Deliver Order",
                                ).box.margin(const EdgeInsets.symmetric(horizontal: 16)).make(),
                        ),
                ],
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}
