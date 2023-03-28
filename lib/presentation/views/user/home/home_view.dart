import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart/models/product_model.dart';
import 'package:emart/services/firestore_services.dart';

import '../../../../consts/app_consts.dart';
import '../product/product_details_view.dart';
import 'search_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final searchController = TextEditingController();

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      color: AppColors.lightGrey,
      height: context.screenHeight,
      child: SafeArea(
        child: Column(
          children: [
            TextFormField(
              controller: searchController,
              onFieldSubmitted: (value) {
                searchController.text.isEmpty
                    ? null
                    : Get.to(() => SearchView(title: searchController.text));
              },
              decoration: InputDecoration(
                filled: true,
                fillColor: AppColors.whiteColor,
                hintText: AppStrings.searchAnything,
                hintStyle: const TextStyle(color: AppColors.textFieldGrey),
                suffixIcon: IconButton(
                  onPressed: () {
                    searchController.text.isEmpty
                        ? null
                        : Get.to(() => SearchView(title: searchController.text));
                  },
                  icon: const Icon(Icons.search_outlined),
                ),
                contentPadding: const EdgeInsetsDirectional.only(start: 16),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            10.heightBox,
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    VxSwiper.builder(
                      aspectRatio: 16 / 9,
                      height: 150,
                      autoPlay: true,
                      enlargeCenterPage: true,
                      enableInfiniteScroll: true,
                      viewportFraction: 0.85,
                      itemCount: AppLists.sliderItems.length,
                      itemBuilder: (context, index) {
                        return Image.asset(
                          AppLists.sliderItems[index],
                          fit: BoxFit.fill,
                        )
                            .box
                            .rounded
                            .clip(Clip.antiAlias)
                            .margin(const EdgeInsets.symmetric(horizontal: 8))
                            .make();
                      },
                    ),
                    10.heightBox,
                    Container(
                      padding: const EdgeInsets.all(12),
                      width: double.infinity,
                      color: AppColors.redColor,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppStrings.featuredProducts.text.white.size(18).fontFamily(AppStyles.bold).make(),
                          10.heightBox,
                          SingleChildScrollView(
                            physics: const BouncingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            child: StreamBuilder<QuerySnapshot>(
                                stream: FirestoreServices.getFeaturedProducts(),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    List<ProductModel> products = List.from(
                                      snapshot.data!.docs.map(
                                        (e) => ProductModel.fromMap(e.data() as Map<String, dynamic>),
                                      ),
                                    );
                                    if (products.isNotEmpty) {
                                      return Row(
                                        children: List.generate(
                                          products.length,
                                          (index) {
                                            return Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                CachedNetworkImage(
                                                  imageUrl: products[index].images.first,
                                                  height: 120,
                                                  width: 120,
                                                  fit: BoxFit.cover,
                                                ),
                                                10.heightBox,
                                                products[index]
                                                    .name
                                                    .text
                                                    .color(AppColors.darkFontGrey)
                                                    .fontFamily(AppStyles.semiBold)
                                                    .make(),
                                                10.heightBox,
                                                "EGP ${products[index].price}"
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
                                                .padding(const EdgeInsets.all(8))
                                                .make()
                                                .onInkTap(() {
                                              Get.to(() => ProductDetailsView(product: products[index]));
                                            });
                                          },
                                        ),
                                      );
                                    } else {
                                      return "No Featured Products".text.white.make();
                                    }
                                  } else {
                                    return const Center(child: CircularProgressIndicator());
                                  }
                                }),
                          ),
                        ],
                      ),
                    ),
                    10.heightBox,
                    "All Products"
                        .text
                        .fontFamily(AppStyles.semiBold)
                        .color(AppColors.darkFontGrey)
                        .size(18)
                        .make(),
                    10.heightBox,
                    StreamBuilder<QuerySnapshot>(
                        stream: FirestoreServices.getAllProducts(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            List<ProductModel> products = List.from(
                              snapshot.data!.docs.map(
                                (e) => ProductModel.fromMap(e.data() as Map<String, dynamic>),
                              ),
                            );
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
                                    "EGP ${products[index].price}"
                                        .text
                                        .color(AppColors.redColor)
                                        .fontFamily(AppStyles.bold)
                                        .size(16)
                                        .make(),
                                  ],
                                ).box.white.roundedSM.padding(const EdgeInsets.all(8)).make().onInkTap(() {
                                  Get.to(() => ProductDetailsView(product: products[index]));
                                });
                              },
                            );
                          } else {
                            return const Center(child: CircularProgressIndicator());
                          }
                        }),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
