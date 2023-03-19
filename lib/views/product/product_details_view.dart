import 'package:cached_network_image/cached_network_image.dart';
import 'package:emart/controllers/product_controller.dart';
import 'package:emart/models/product_model.dart';
import 'package:emart/views/chat/chat_view.dart';

import '../../consts/app_consts.dart';
import '../common/custom_button.dart';

class ProductDetailsView extends StatefulWidget {
  const ProductDetailsView({Key? key, required this.product}) : super(key: key);

  final ProductModel product;

  @override
  State<ProductDetailsView> createState() => _ProductDetailsViewState();
}

class _ProductDetailsViewState extends State<ProductDetailsView> {
  var controller = Get.put(ProductController());

  @override
  void initState() {
    controller.isFavorite(widget.product.wishlist.contains(AppFirebase.currentUser!.uid));
    controller.totalPrice(controller.quantity.value * widget.product.price.toDouble());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        title:
            widget.product.name.text.fontFamily(AppStyles.bold).color(AppColors.darkFontGrey).ellipsis.make(),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.share_outlined),
          ),
          Obx(
            () => IconButton(
              onPressed: () {
                controller.addToWishlist(id: widget.product.id);
              },
              icon: Icon(controller.isFavorite.value ? Icons.favorite : Icons.favorite_outline),
              color: controller.isFavorite.value ? AppColors.redColor:AppColors.darkFontGrey,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    VxSwiper.builder(
                      itemCount: widget.product.images.length,
                      height: 350,
                      aspectRatio: 16 / 9,
                      viewportFraction: 1.0,
                      itemBuilder: (context, index) {
                        return CachedNetworkImage(
                          imageUrl: widget.product.images[index],
                          width: double.infinity,
                          fit: BoxFit.cover,
                        );
                      },
                    ),
                    10.heightBox,
                    widget.product.name.text
                        .size(16)
                        .color(AppColors.darkFontGrey)
                        .fontFamily(AppStyles.semiBold)
                        .make(),
                    10.heightBox,
                    VxRating(
                      isSelectable: false,
                      onRatingUpdate: (value) {},
                      count: 5,
                      maxRating: 5,
                      value: widget.product.rating.toDouble(),
                      normalColor: AppColors.textFieldGrey,
                      selectionColor: AppColors.golden,
                      size: 25,
                    ),
                    10.heightBox,
                    "\$${widget.product.price}"
                        .text
                        .color(AppColors.redColor)
                        .size(18)
                        .fontFamily(AppStyles.bold)
                        .make(),
                    10.heightBox,
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              "Seller".text.white.fontFamily(AppStyles.semiBold).make(),
                              5.heightBox,
                              widget.product.seller.text
                                  .color(AppColors.darkFontGrey)
                                  .fontFamily(AppStyles.semiBold)
                                  .size(16)
                                  .make(),
                            ],
                          ),
                        ),
                        CircleAvatar(
                          backgroundColor: Colors.white,
                          child: IconButton(
                            onPressed: () {
                              Get.to(
                                () => ChatView(
                                  sellerId: widget.product.sellerId,
                                  sellerName: widget.product.seller,
                                ),
                              );
                            },
                            icon: const Icon(Icons.message_rounded),
                            color: AppColors.darkFontGrey,
                          ),
                        ),
                      ],
                    )
                        .box
                        .height(60)
                        .padding(const EdgeInsets.symmetric(horizontal: 16))
                        .color(AppColors.textFieldGrey)
                        .make(),
                    20.heightBox,
                    Column(
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              width: 60,
                              child: "Color: ".text.color(AppColors.textFieldGrey).make(),
                            ),
                            15.widthBox,
                            Expanded(
                              child: SingleChildScrollView(
                                physics: const BouncingScrollPhysics(),
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: List.generate(
                                    widget.product.colors.length,
                                    (index) {
                                      return Obx(
                                        () => Stack(
                                          alignment: Alignment.center,
                                          children: [
                                            VxBox()
                                                .size(40, 40)
                                                .roundedFull
                                                .color(Color(widget.product.colors[index].toInt()))
                                                .margin(const EdgeInsets.all(4))
                                                .make()
                                                .onInkTap(() {
                                              controller.selectedColorIndex(index);
                                            }),
                                            Icon(
                                              controller.selectedColorIndex.value == index
                                                  ? Icons.done
                                                  : null,
                                              color: Colors.white,
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ).box.padding(const EdgeInsets.all(8)).make(),
                        Obx(
                          () => Row(
                            children: [
                              SizedBox(
                                width: 60,
                                child: "Quantity: ".text.color(AppColors.textFieldGrey).make(),
                              ),
                              15.widthBox,
                              Row(
                                children: [
                                  IconButton(
                                    onPressed: () => controller.decreaseQuantity(product: widget.product),
                                    // onPressed: controller.quantity.value == 1
                                    //     ? null
                                    //     : () {
                                    //         controller.quantity.value -= 1;
                                    //       },
                                    icon: const Icon(Icons.remove),
                                  ),
                                  controller.quantity.value.text.size(16).make(),
                                  IconButton(
                                    onPressed: () => controller.increaseQuantity(product: widget.product),
                                    // onPressed: !(product.quantity - controller.quantity.value > 0)
                                    //     ? null
                                    //     : () {
                                    //         controller.quantity.value += 1;
                                    //       },
                                    icon: const Icon(Icons.add),
                                  ),
                                  10.widthBox,
                                  "( ${widget.product.quantity} Available )"
                                      .text
                                      .color(AppColors.textFieldGrey)
                                      .make(),
                                ],
                              ),
                            ],
                          ).box.padding(const EdgeInsets.all(8)).make(),
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: 60,
                              child: "Total: ".text.color(AppColors.textFieldGrey).make(),
                            ),
                            15.widthBox,
                            Obx(
                              () => "\$${controller.totalPrice.value}"
                                  .text
                                  .color(AppColors.redColor)
                                  .fontFamily(AppStyles.bold)
                                  .size(16)
                                  .make(),
                            ),
                          ],
                        ).box.padding(const EdgeInsets.all(8)).make(),
                      ],
                    ).box.white.roundedSM.shadowSm.make(),
                    10.heightBox,
                    "Description".text.fontFamily(AppStyles.semiBold).color(AppColors.darkFontGrey).make(),
                    10.heightBox,
                    widget.product.description.text.color(AppColors.darkFontGrey).make(),
                    10.heightBox,
                    ListTile(
                      title: "Video".text.color(AppColors.darkFontGrey).fontFamily(AppStyles.semiBold).make(),
                      trailing: const Icon(Icons.arrow_forward),
                    ),
                    10.heightBox,
                    ListTile(
                      title:
                          "Reviews".text.color(AppColors.darkFontGrey).fontFamily(AppStyles.semiBold).make(),
                      trailing: const Icon(Icons.arrow_forward),
                    ),
                    10.heightBox,
                    ListTile(
                      title: "Seller Policy"
                          .text
                          .color(AppColors.darkFontGrey)
                          .fontFamily(AppStyles.semiBold)
                          .make(),
                      trailing: const Icon(Icons.arrow_forward),
                    ),
                    10.heightBox,
                    ListTile(
                      title: "Return Policy"
                          .text
                          .color(AppColors.darkFontGrey)
                          .fontFamily(AppStyles.semiBold)
                          .make(),
                      trailing: const Icon(Icons.arrow_forward),
                    ),
                    10.heightBox,
                    ListTile(
                      title: "Support Policy"
                          .text
                          .color(AppColors.darkFontGrey)
                          .fontFamily(AppStyles.semiBold)
                          .make(),
                      trailing: const Icon(Icons.arrow_forward),
                    ),
                    20.heightBox,
                    "Products you may like"
                        .text
                        .size(16)
                        .color(AppColors.darkFontGrey)
                        .fontFamily(AppStyles.bold)
                        .make(),
                    10.heightBox,
                    SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: List.generate(
                          6,
                          (index) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image.asset(
                                  AppImages.imgP1,
                                  width: 120,
                                  fit: BoxFit.cover,
                                ),
                                10.heightBox,
                                "Laptop 4GB/64GB"
                                    .text
                                    .color(AppColors.darkFontGrey)
                                    .fontFamily(AppStyles.semiBold)
                                    .make(),
                                10.heightBox,
                                "\$600"
                                    .text
                                    .color(AppColors.redColor)
                                    .fontFamily(AppStyles.bold)
                                    .size(16)
                                    .make(),
                              ],
                            )
                                .box
                                .white
                                .roundedSM
                                .shadowSm
                                .padding(const EdgeInsets.all(8))
                                .margin(const EdgeInsets.all(6))
                                .make();
                          },
                        ),
                      ),
                    ),
                    10.heightBox,
                  ],
                ),
              ),
            ),
            CustomButton(
              onPressed: () {
                controller.addToCart(product: widget.product);
              },
              text: "Add to Cart",
            ),
          ],
        ),
      ),
    );
  }
}
