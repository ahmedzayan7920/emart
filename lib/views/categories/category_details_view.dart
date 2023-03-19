import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart/controllers/category_controller.dart';
import 'package:emart/models/product_model.dart';
import 'package:emart/services/firestore_services.dart';
import 'package:emart/views/common/custom_background.dart';
import 'package:emart/views/product/product_details_view.dart';

import '../../consts/app_consts.dart';

class CategoryDetailsView extends StatelessWidget {
  const CategoryDetailsView({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<CategoryController>();
    return CustomBackground(
      child: Scaffold(
        appBar: AppBar(
          title: title.text.fontFamily(AppStyles.bold).make(),
          shadowColor: Colors.transparent,
          iconTheme: const IconThemeData(color: AppColors.whiteColor),
        ),
        body: Padding(
          padding: const EdgeInsets.all(12),
          child: StreamBuilder<QuerySnapshot>(
              stream: FirestoreServices.getCategoryProducts(category: title),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        physics: const BouncingScrollPhysics(),
                        child: Row(
                          children: List.generate(
                            controller.subCategories.length,
                            (index) {
                              return controller.subCategories[index].text
                                  .fontFamily(AppStyles.semiBold)
                                  .color(AppColors.darkFontGrey)
                                  .size(12)
                                  .center
                                  .makeCentered()
                                  .box
                                  .white
                                  .roundedSM
                                  .margin(const EdgeInsets.symmetric(horizontal: 4))
                                  .size(120, 60)
                                  .make();
                            },
                          ),
                        ),
                      ),
                      10.heightBox,
                      Expanded(
                        child: GridView.builder(
                          itemCount: snapshot.data!.docs.length,
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 10,
                            mainAxisExtent: 230,
                          ),
                          itemBuilder: (context, index) {
                            ProductModel product = ProductModel.fromMap(
                                snapshot.data!.docs[index].data() as Map<String, dynamic>);
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CachedNetworkImage(
                                  imageUrl: product.images[0],
                                  height: 150,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                ).box.topRounded(value: 7.5).clip(Clip.antiAlias).make(),
                                const Spacer(),
                                product.name.text
                                    .color(AppColors.darkFontGrey)
                                    .fontFamily(AppStyles.semiBold)
                                    .maxLines(2)
                                    .ellipsis
                                    .make(),
                                10.heightBox,
                                "\$${product.price}"
                                    .text
                                    .color(AppColors.redColor)
                                    .fontFamily(AppStyles.bold)
                                    .size(16)
                                    .make(),
                              ],
                            ).box.white.roundedSM.shadowSm.padding(const EdgeInsets.all(8)).make().onInkTap(
                              () {
                                Get.to(() => ProductDetailsView(product: product));
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  );
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              }),
        ),
      ),
    );
  }
}
