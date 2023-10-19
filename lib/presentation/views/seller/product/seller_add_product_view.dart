import 'package:emart/presentation/widgets/custom_button.dart';

import '../../../../consts/app_consts.dart';
import '../../../../controllers/seller_product_controller.dart';
import '../../../widgets/custom_text_field.dart';

class SellerAddProductView extends StatefulWidget {
  const SellerAddProductView({Key? key}) : super(key: key);

  @override
  State<SellerAddProductView> createState() => _SellerAddProductViewState();
}

class _SellerAddProductViewState extends State<SellerAddProductView> {
  var controller = Get.put(SellerProductController());

  @override
  void dispose() {
    controller.nameController.clear();
    controller.descriptionController.clear();
    controller.priceController.clear();
    controller.shippingPriceController.clear();
    controller.quantityController.clear();
    controller.categoryValue.value = "";
    controller.subCategoryValue.value = "";
    controller.images.value = [null, null, null];
    controller.imagesUrl = [null, null, null];
    controller.selectedColors.value = [0];
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: "Add Product".text.color(AppColors.darkFontGrey).fontFamily(AppStyles.semiBold).make(),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Form(
                    key: controller.formKey,
                    child: Column(
                      children: [
                        CustomTextField(
                          title: "Name",
                          hint: "eg. BMW",
                          controller: controller.nameController,
                        ),
                        10.heightBox,
                        CustomTextField(
                          title: "Description",
                          hint: "eg. Nice Product",
                          maxLines: 4,
                          controller: controller.descriptionController,
                        ),
                        10.heightBox,
                        CustomTextField(
                          title: "Price",
                          hint: "eg. EGP 100",
                          controller: controller.priceController,
                          keyboardType:  TextInputType.number,
                        ),
                        10.heightBox,
                        CustomTextField(
                          title: "Shipping Price",
                          hint: "eg. EGP 7",
                          controller: controller.shippingPriceController,
                          keyboardType:  TextInputType.number,
                        ),
                        10.heightBox,
                        CustomTextField(
                          title: "Quantity",
                          hint: "eg. 25",
                          controller: controller.quantityController,
                          keyboardType:  TextInputType.number,
                        ),
                      ],
                    ),
                  ),
                  10.heightBox,
                  Obx(
                    () => DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        hint: "Category".text.make(),
                        value: controller.categoryValue.value == "" ? null : controller.categoryValue.value,
                        isExpanded: true,
                        items: controller.categories
                            .map(
                              (e) => DropdownMenuItem<String>(
                                value: e,
                                child: e.text.make(),
                              ),
                            )
                            .toList(),
                        onChanged: (value) {
                          controller.categoryValue(value);
                          controller.subCategoryValue("");
                          controller.getSubCategories(category: value!);
                        },
                      ),
                    ),
                  ),
                  10.heightBox,
                  Obx(
                    () => DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        hint: "Sub Category".text.make(),
                        value: controller.subCategoryValue.value == ""
                            ? null
                            : controller.subCategoryValue.value,
                        isExpanded: true,
                        items: controller.subCategories
                            .map(
                              (e) => DropdownMenuItem<String>(
                                value: e,
                                child: e.text.make(),
                              ),
                            )
                            .toList(),
                        onChanged: (value) {
                          controller.subCategoryValue(value);
                        },
                      ),
                    ),
                  ),
                  10.heightBox,
                  "Images".text.color(AppColors.redColor).fontFamily(AppStyles.semiBold).size(16).make(),
                  10.heightBox,
                  Obx(
                    () => Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: List.generate(
                        3,
                        (index) => controller.images[index] != null
                            ? Image.file(
                                controller.images[index]!,
                                fit: BoxFit.fill,
                              ).box.size(100, 100).roundedSM.clip(Clip.antiAlias).make().onInkTap(() {
                                controller.pickImage(index: index);
                              })
                            : (index + 1)
                                .text
                                .fontFamily(AppStyles.bold)
                                .makeCentered()
                                .box
                                .color(AppColors.lightGrey)
                                .size(100, 100)
                                .roundedSM
                                .make()
                                .onInkTap(() {
                                controller.pickImage(index: index);
                              }),
                      ),
                    ),
                  ),
                  10.heightBox,
                  "Colors".text.color(AppColors.redColor).fontFamily(AppStyles.semiBold).size(16).make(),
                  10.heightBox,
                  Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    runAlignment: WrapAlignment.center,
                    children: List.generate(
                      Colors.primaries.length,
                      (index) => Obx(
                        () => Stack(
                          alignment: Alignment.center,
                          children: [
                            VxBox().color(Colors.primaries[index]).roundedFull.size(50, 50).make(),
                            Icon(controller.selectedColors.contains(index) ? Icons.done : null,
                                color: Colors.white),
                          ],
                        ).onInkTap(() {
                          controller.selectedColors.contains(index)
                              ? controller.selectedColors.remove(index)
                              : controller.selectedColors.add(index);
                        }),
                      ),
                    ),
                  ),
                  10.heightBox,
                  CustomButton(
                    onPressed: () {
                      FocusManager.instance.primaryFocus?.unfocus();
                      controller.uploadProduct(context: context);
                    },
                    text: "Add",
                  ),
                ],
              ),
            ),
          ),
        ),
        Obx(
          () => controller.isUploading.value
              ? Container(
                  width: double.infinity,
                  height: double.infinity,
                  color: Colors.grey.withOpacity(.4),
                  child: const Column(
                    children: [
                      SafeArea(child: LinearProgressIndicator()),
                    ],
                  ),
                )
              : const SizedBox.shrink(),
        ),
      ],
    );
  }
}
