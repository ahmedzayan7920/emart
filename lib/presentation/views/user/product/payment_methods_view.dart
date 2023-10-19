import 'package:emart/controllers/product_controller.dart';

import '../../../../consts/app_consts.dart';
import '../../../widgets/custom_button.dart';

class PaymentMethodsView extends StatefulWidget {
  const PaymentMethodsView({Key? key}) : super(key: key);

  @override
  State<PaymentMethodsView> createState() => _PaymentMethodsViewState();
}

class _PaymentMethodsViewState extends State<PaymentMethodsView> {
  var controller = Get.find<ProductController>();

  @override
  void dispose() {
    controller.selectedPaymentIndex(0);
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        title:
            "Choose Payment Method".text.color(AppColors.darkFontGrey).fontFamily(AppStyles.semiBold).make(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Expanded(
              child: ListView.separated(
                itemCount: AppLists.paymentImages.length,
                separatorBuilder: (context, index) => 10.heightBox,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      controller.selectedPaymentIndex(index);
                    },
                    child: Obx(
                      () => Stack(
                        alignment: AlignmentDirectional.topEnd,
                        children: [
                          Image.asset(
                            AppLists.paymentImages[index],
                            height: 120,
                            width: double.infinity,
                            fit: BoxFit.cover,
                            color: controller.selectedPaymentIndex.value == index
                                ? Colors.black.withOpacity(0.5)
                                : Colors.transparent,
                            colorBlendMode: controller.selectedPaymentIndex.value == index
                                ? BlendMode.darken
                                : BlendMode.color,
                          )
                              .box
                              .roundedSM
                              .shadowSm
                              .clip(Clip.antiAlias)
                              .border(
                                  color: controller.selectedPaymentIndex.value == index ?AppColors.redColor:Colors.transparent,
                                  width: controller.selectedPaymentIndex.value == index ? 4 : 0,
                                  style: BorderStyle.solid)
                              .make(),
                          controller.selectedPaymentIndex.value == index
                              ? const Padding(
                                  padding: EdgeInsetsDirectional.all(12),
                                  child: CircleAvatar(
                                    radius: 14,
                                    backgroundColor: AppColors.redColor,
                                    child: Icon(Icons.done, size: 22),
                                  ),
                                )
                              : const SizedBox.shrink(),
                          PositionedDirectional(
                            bottom: 10,
                            start: 10,
                            child: AppLists.paymentTitles[index].text.white
                                .size(16)
                                .fontFamily(AppStyles.semiBold)
                                .make().box.color(Colors.black.withOpacity(0.5)).padding(const EdgeInsets.all(4)).roundedSM.make(),
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            Obx(
                ()=>
                controller.isPlacingOrder.value? const Center(child: CircularProgressIndicator()):CustomButton(
                onPressed: () {
                  controller.placeMyOrder(context: context);
                },
                text: "Place my order",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
