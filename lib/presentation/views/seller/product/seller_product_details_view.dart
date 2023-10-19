import 'package:cached_network_image/cached_network_image.dart';
import 'package:emart/models/product_model.dart';

import '../../../../consts/app_consts.dart';

class SellerProductDetailsView extends StatelessWidget {
  const SellerProductDetailsView({Key? key, required this.product}) : super(key: key);

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        title:
            product.name.text.fontFamily(AppStyles.bold).color(AppColors.darkFontGrey).ellipsis.make(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              VxSwiper.builder(
                itemCount: product.images.length,
                height: 350,
                aspectRatio: 16 / 9,
                viewportFraction: 1.0,
                enableInfiniteScroll: false,
                scrollPhysics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  return CachedNetworkImage(
                    imageUrl: product.images[index],
                    width: double.infinity,
                    fit: BoxFit.cover,
                  );
                },
              ),
              10.heightBox,
              product.name.text
                  .size(18)
                  .color(AppColors.darkFontGrey)
                  .fontFamily(AppStyles.bold)
                  .make(),
              10.heightBox,
              Row(
                children: [
                  product.category.text
                      .size(16)
                      .color(AppColors.darkFontGrey)
                      .fontFamily(AppStyles.semiBold)
                      .make(),
                  "   -   ${product.subCategory}".text
                      .size(16)
                      .color(AppColors.darkFontGrey)
                      .fontFamily(AppStyles.semiBold)
                      .make(),
                ],
              ),
              10.heightBox,
              Row(
                children: [
                  "EGP ${product.price}"
                      .text
                      .color(AppColors.redColor)
                      .size(18)
                      .fontFamily(AppStyles.bold)
                      .make(),
                  "  +  EGP ${product.shippingPrice}"
                      .text
                      .color(AppColors.redColor)
                      .size(18)
                      .fontFamily(AppStyles.bold)
                      .make(),
                  "  (for shipping)"
                      .text
                      .color(AppColors.textFieldGrey)
                      .size(16)

                      .make(),
                ],
              ),
              Row(
                children: [
                  SizedBox(
                    width: 70,
                    child: "Color: ".text.color(AppColors.fontGrey).size(16).make(),
                  ),
                  15.widthBox,
                  Expanded(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: List.generate(
                          product.colors.length,
                          (index) {
                            return VxBox()
                                  .size(40, 40)
                                  .roundedFull
                                  .color(Color(product.colors[index].toInt()))
                                  .margin(const EdgeInsets.all(4))
                                  .make();
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ).box.padding(const EdgeInsets.all(8)).make(),
              Row(
                  children: [
                    SizedBox(
                      width: 70,
                      child: "Quantity: ".text.color(AppColors.fontGrey).size(16).make(),
                    ),
                    15.widthBox,
                    "${product.quantity} Item"
                        .text
                        .color(AppColors.darkFontGrey).size(16)
                        .make(),
                  ],
                ).box.padding(const EdgeInsets.all(8)).make(),
              10.heightBox,
              "Description"
                  .text
                  .size(18)
                  .fontFamily(AppStyles.semiBold)
                  .color(AppColors.darkFontGrey)
                  .make(),
              10.heightBox,
              product.description.text.color(AppColors.darkFontGrey).size(16).make(),
            ],
          ),
        ),
      ),
    );
  }
}
