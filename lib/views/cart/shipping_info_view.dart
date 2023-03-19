import 'package:emart/views/cart/payment_methods_view.dart';
import 'package:emart/views/common/custom_button.dart';
import 'package:emart/views/common/custom_text_field.dart';

import '../../consts/app_consts.dart';

class ShippingInfoView extends StatefulWidget {
  const ShippingInfoView({Key? key}) : super(key: key);

  @override
  State<ShippingInfoView> createState() => _ShippingInfoViewState();
}

class _ShippingInfoViewState extends State<ShippingInfoView> {
  final addressController = TextEditingController();
  final cityController = TextEditingController();
  final stateController = TextEditingController();
  final postalCodeController = TextEditingController();
  final phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        title: "Shipping Info".text.color(AppColors.darkFontGrey).fontFamily(AppStyles.semiBold).make(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    CustomTextField(title: "Address", hint: "Address", controller: addressController),
                    CustomTextField(title: "City", hint: "City", controller: cityController),
                    CustomTextField(title: "Sate", hint: "Sate", controller: stateController),
                    CustomTextField(
                        title: "Postal Code", hint: "Postal Code", controller: postalCodeController),
                    CustomTextField(title: "Phone", hint: "Phone", controller: phoneController),
                  ],
                ),
              ),
            ),
            CustomButton(
              onPressed: () {
                Get.to(() => const PaymentMethodsView());
              },
              text: "Confirm",
            ),
          ],
        ),
      ),
    );
  }
}
