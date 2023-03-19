import 'package:emart/controllers/main_controller.dart';
import 'package:emart/views/cart/cart_view.dart';
import 'package:emart/views/categories/categories_view.dart';
import 'package:emart/views/common/custom_exit_dialog.dart';
import 'package:emart/views/home/home_view.dart';
import 'package:emart/views/profile/profile_view.dart';

import '../../consts/app_consts.dart';

class MainView extends StatelessWidget {
  const MainView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(MainController());

    var bodyItems = [
      const HomeView(),
      const CategoriesView(),
      const CartView(),
      const ProfileView(),
    ];

    var navItems = [
      BottomNavigationBarItem(
        icon: Image.asset(AppImages.icHome, width: 26),
        label: AppStrings.home,
      ),
      BottomNavigationBarItem(
        icon: Image.asset(AppImages.icCategories, width: 26),
        label: AppStrings.categories,
      ),
      BottomNavigationBarItem(
        icon: Image.asset(AppImages.icCart, width: 26),
        label: AppStrings.cart,
      ),
      BottomNavigationBarItem(
        icon: Image.asset(AppImages.icProfile, width: 26),
        label: AppStrings.profile,
      ),
    ];

    return WillPopScope(
      onWillPop: () async {
        showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) => const CustomExitDialog(),
        );
        return false;
      },
      child: Scaffold(
        body: Obx(
          () => bodyItems[controller.currentIndex.value],
        ),
        bottomNavigationBar: Obx(
          () => BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            items: navItems,
            selectedItemColor: AppColors.redColor,
            currentIndex: controller.currentIndex.value,
            onTap: (value) {
              // print("**********");
              // print(AppFirebase.currentUser?.displayName);
              // print("**********");
              controller.currentIndex.value = value;
            },
          ),
        ),
      ),
    );
  }
}
