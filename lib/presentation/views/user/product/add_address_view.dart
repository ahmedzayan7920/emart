import 'package:emart/controllers/product_controller.dart';
import 'package:emart/presentation/widgets/custom_button.dart';

import '../../../../consts/app_consts.dart';
import '../../../widgets/custom_text_field.dart';

class AddAddressView extends StatefulWidget {
  const AddAddressView({Key? key}) : super(key: key);

  @override
  State<AddAddressView> createState() => _AddAddressViewState();
}

class _AddAddressViewState extends State<AddAddressView> {
  final addressController = TextEditingController();
  final cityController = TextEditingController();
  final stateController = TextEditingController();
  final countryController = TextEditingController();
  final postalCodeController = TextEditingController();
  final phoneController = TextEditingController();

  var controller = Get.find<ProductController>();

  final formKey = GlobalKey<FormState>();

  login() {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      FocusManager.instance.primaryFocus?.unfocus();
      controller.saveAddress(context: context,
        address: addressController.text,
        city: cityController.text,
        state: stateController.text,
        country: countryController.text,
        postalCode: postalCodeController.text,
        phone: phoneController.text,
      );
    }
  }

  @override
  void dispose() {
    addressController.dispose();
    cityController.dispose();
    stateController.dispose();
    countryController.dispose();
    postalCodeController.dispose();
    phoneController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        title: "Add New Address".text.color(AppColors.darkFontGrey).fontFamily(AppStyles.semiBold).make(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Form(
                      key: formKey,
                      child: Column(
                        children: [
                          CustomTextField(
                            title: "Address",
                            hint: "Address",
                            controller: addressController,
                          ),
                          CustomTextField(
                            title: "City",
                            hint: "City",
                            controller: cityController,
                          ),
                          CustomTextField(
                            title: "Sate",
                            hint: "Sate",
                            controller: stateController,
                          ),
                          CustomTextField(
                            title: "Country",
                            hint: "Country",
                            controller: countryController,
                          ),
                          CustomTextField(
                            title: "Postal Code",
                            hint: "Postal Code",
                            controller: postalCodeController,
                            keyboardType:  TextInputType.number,
                          ),
                          CustomTextField(
                            title: "Phone",
                            hint: "Phone",
                            controller: phoneController,
                            keyboardType:  TextInputType.number,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Obx(
              () => controller.isAddingAddress.value? const Center(child: CircularProgressIndicator()):CustomButton(
                onPressed: login,
                text: "Save",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
