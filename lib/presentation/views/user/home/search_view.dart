import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../consts/app_consts.dart';
import '../../../../models/product_model.dart';
import '../../../../services/firestore_services.dart';
import '../product/product_details_view.dart';

class SearchView extends StatelessWidget {
  const SearchView({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: title.text.color(AppColors.darkFontGrey).fontFamily(AppStyles.semiBold).make(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: FutureBuilder<QuerySnapshot>(
            future: FirestoreServices.searchForProduct(query: title),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<ProductModel> data = List.from(
                  snapshot.data!.docs.map(
                    (e) => ProductModel.fromMap(e.data() as Map<String, dynamic>),
                  ),
                );
                var products = data.where((element) => element.name.toLowerCase().contains(title.toLowerCase())).toList();
                return GridView.builder(
                  itemCount: products.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    mainAxisExtent: 280,
                  ),
                  itemBuilder: (context, index) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CachedNetworkImage(
                          imageUrl: products[index].images.first,
                          width: 200,
                          height: 200,
                          fit: BoxFit.cover,
                        ),
                        const Spacer(),
                        products[index]
                            .name
                            .text
                            .color(AppColors.darkFontGrey)
                            .fontFamily(AppStyles.semiBold)
                            .maxLines(2)
                            .ellipsis
                            .make(),
                        10.heightBox,
                        "\$${products[index].price}"
                            .text
                            .color(AppColors.redColor)
                            .fontFamily(AppStyles.bold)
                            .size(16)
                            .make(),
                      ],
                    ).box.white.roundedSM.clip(Clip.antiAlias).shadowSm.padding(const EdgeInsets.all(8)).make().onInkTap(() {
                      Get.to(() => ProductDetailsView(product: products[index]));
                    });
                  },
                );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            }),
      ),
    );
  }
}
