import 'package:emart/views/common/custom_home_button.dart';
import 'package:emart/views/home/widgets/custom_featured_button.dart';

import '../../consts/app_consts.dart';
import 'widgets/custom_image_slider.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

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
              decoration: InputDecoration(
                filled: true,
                fillColor: AppColors.whiteColor,
                hintText: AppStrings.searchAnything,
                hintStyle: const TextStyle(color: AppColors.textFieldGrey),
                suffixIcon: const Icon(Icons.search_outlined),
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
                    const CustomImageSlider(items: AppLists.sliderItems),
                    10.heightBox,
                    Row(
                      children: [
                        CustomHomeButton(
                          title: AppStrings.todayDeal,
                          imagePath: AppImages.icTodayDeal,
                          height: context.screenHeight * .15,
                        ),
                        15.widthBox,
                        CustomHomeButton(
                          title: AppStrings.flashSale,
                          imagePath: AppImages.icFlashDeal,
                          height: context.screenHeight * .15,
                        ),
                      ],
                    ),
                    10.heightBox,
                    const CustomImageSlider(items: AppLists.sliderItems),
                    10.heightBox,
                    Row(
                      children: [
                        CustomHomeButton(
                          title: AppStrings.topCategories,
                          imagePath: AppImages.icTopCategories,
                          height: context.screenHeight * .15,
                        ),
                        10.widthBox,
                        CustomHomeButton(
                          title: AppStrings.brand,
                          imagePath: AppImages.icBrands,
                          height: context.screenHeight * .15,
                        ),
                        10.widthBox,
                        CustomHomeButton(
                          title: AppStrings.topSellers,
                          imagePath: AppImages.icTopSeller,
                          height: context.screenHeight * .15,
                        ),
                      ],
                    ),
                    10.heightBox,
                    AppStrings.featuredCategories.text
                        .fontFamily(AppStyles.semiBold)
                        .color(AppColors.darkFontGrey)
                        .size(18)
                        .make(),
                    10.heightBox,
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      child: Row(
                        children: [
                          Column(
                            children: [
                              const CustomFeaturedButton(
                                  title: AppStrings.womenDress, image: AppImages.imgS1),
                              10.heightBox,
                              const CustomFeaturedButton(
                                  title: AppStrings.boysGlasses, image: AppImages.imgS4),
                            ],
                          ),
                          10.widthBox,
                          Column(
                            children: [
                              const CustomFeaturedButton(
                                  title: AppStrings.girlsDress, image: AppImages.imgS2),
                              10.heightBox,
                              const CustomFeaturedButton(
                                  title: AppStrings.mobilePhones, image: AppImages.imgS5),
                            ],
                          ),
                          10.widthBox,
                          Column(
                            children: [
                              const CustomFeaturedButton(
                                  title: AppStrings.girlsWatches, image: AppImages.imgS3),
                              10.heightBox,
                              const CustomFeaturedButton(title: AppStrings.tShirts, image: AppImages.imgS6),
                            ],
                          ),
                        ],
                      ),
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
                                      .padding(const EdgeInsets.all(8))
                                      .margin(const EdgeInsets.symmetric(horizontal: 6))
                                      .make();
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    10.heightBox,
                    const CustomImageSlider(items: AppLists.sliderItems),
                    10.heightBox,
                    AppStrings.featuredCategories.text
                        .fontFamily(AppStyles.semiBold)
                        .color(AppColors.darkFontGrey)
                        .size(18)
                        .make(),
                    10.heightBox,
                    GridView.builder(
                      itemCount: 6,
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
                            Image.asset(
                              AppImages.imgP5,
                              width: 200,
                              height: 200,
                              fit: BoxFit.cover,
                            ),
                            const Spacer(),
                            "Laptop 4GB/64GB"
                                .text
                                .color(AppColors.darkFontGrey)
                                .fontFamily(AppStyles.semiBold).maxLines(2).ellipsis
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
                            .padding(const EdgeInsets.all(8))
                            .make();
                      },
                    ),
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
