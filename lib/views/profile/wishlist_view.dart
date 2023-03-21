import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../consts/app_consts.dart';
import '../../models/product_model.dart';
import '../../services/firestore_services.dart';

class WishlistView extends StatelessWidget {
  const WishlistView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: "Wishlist".text.color(AppColors.darkFontGrey).fontFamily(AppStyles.semiBold).make(),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: StreamBuilder<QuerySnapshot>(
            stream: FirestoreServices.getWishlist(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<ProductModel> products = List.from(
                  snapshot.data!.docs.map(
                    (e) => ProductModel.fromMap(e.data() as Map<String, dynamic>),
                  ),
                );
                return ListView.builder(
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    return Row(
                      children: [
                        CachedNetworkImage(
                          imageUrl: products[index].images.first,
                          fit: BoxFit.fill,
                          height: 100,
                          width: 100,
                        ),
                        10.widthBox,
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              products[index]
                                  .name
                                  .text
                                  .size(16)
                                  .fontFamily(AppStyles.semiBold)
                                  .color(AppColors.darkFontGrey)
                                  .make(),
                              10.heightBox,
                              "\$${products[index].price}"
                                  .text
                                  .size(16)
                                  .fontFamily(AppStyles.semiBold)
                                  .color(AppColors.redColor)
                                  .make(),
                            ],
                          ),
                        ),
                        10.widthBox,
                        IconButton(
                          onPressed: () async {
                            await AppFirebase.firestore
                                .collection(AppFirebase.productsCollection)
                                .doc(products[index].id)
                                .update({
                              "wishlist": FieldValue.arrayRemove(
                                [AppFirebase.currentUser!.uid],
                              ),
                            });
                          },
                          icon: const Icon(
                            Icons.favorite,
                            color: AppColors.redColor,
                            size: 30,
                          ),
                        ),
                        10.widthBox,
                      ],
                    ).box.white.shadowSm.roundedSM.clip(Clip.antiAlias).make();
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
