import 'package:emart/controllers/category_controller.dart';

import '../../../../consts/app_consts.dart';
import '../../../widgets/custom_background.dart';
import 'category_details_view.dart';

class CategoriesView extends StatelessWidget {
  const CategoriesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(CategoryController());
    return CustomBackground(
      child: Column(
        children: [
          AppBar(
            shadowColor: Colors.transparent,
            title: AppStrings.categories.text.white.fontFamily(AppStyles.bold).make(),
          ),
          Expanded(
            child: GridView.builder(
              itemCount: AppLists.categoriesImages.length,
              padding: const EdgeInsets.all(12),
              physics: const BouncingScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                mainAxisExtent: 190,
              ),
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Image.asset(
                      AppLists.categoriesImages[index],
                      height: 120,
                      width: 200,
                      fit: BoxFit.cover,
                    ),
                    10.heightBox,
                    AppLists.categoriesTitles[index].text.center
                        .color(AppColors.darkFontGrey)
                        .maxLines(2)
                        .ellipsis
                        .make(),
                  ],
                )
                    .box
                    .white
                    .roundedSM
                    .padding(const EdgeInsets.all(8))
                    .clip(Clip.antiAlias)
                    .outerShadowSm
                    .make()
                    .onInkTap(() async {
                  await controller.getSubCategories(title: AppLists.categoriesTitles[index]);
                  Get.to(() => CategoryDetailsView(title: AppLists.categoriesTitles[index]));
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
