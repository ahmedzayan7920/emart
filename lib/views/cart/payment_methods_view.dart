import 'package:emart/controllers/cart_controller.dart';

import '../../consts/app_consts.dart';
import '../common/custom_button.dart';

class PaymentMethodsView extends StatelessWidget {
  const PaymentMethodsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<CartController>();
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
                                  color: AppColors.redColor,
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
            CustomButton(
              onPressed: () {
                Get.to(() => const PaymentMethodsView());
              },
              text: "Place my order",
            ),
          ],
        ),
      ),
    );
  }
}
