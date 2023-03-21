import 'package:emart/views/categories/categories_view.dart';
import 'package:emart/views/common/custom_exit_dialog.dart';
import 'package:emart/views/home/home_view.dart';
import 'package:emart/views/profile/profile_view.dart';

import '../../consts/app_consts.dart';

class MainView extends StatefulWidget {
  const MainView({Key? key}) : super(key: key);

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  var currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    var bodyItems = [
      const HomeView(),
      const CategoriesView(),
      const ProfileView(),
    ];

    var navItems = [
      BottomNavigationBarItem(
        icon: Image.asset(
          AppImages.icHome,
          width: 26,
          color: currentIndex == 0 ? AppColors.redColor : Colors.grey,
        ),
        label: AppStrings.home,
      ),
      BottomNavigationBarItem(
        icon: Image.asset(
          AppImages.icCategories,
          width: 26,
          color: currentIndex == 1 ? AppColors.redColor : Colors.grey,
        ),
        label: AppStrings.categories,
      ),
      BottomNavigationBarItem(
        icon: Image.asset(
          AppImages.icProfile,
          width: 26,
          color: currentIndex == 2 ? AppColors.redColor : Colors.grey,
        ),
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
        body: bodyItems[currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          items: navItems,
          selectedItemColor: AppColors.redColor,
          currentIndex: currentIndex,
          onTap: (value) {
            setState(() {
              currentIndex = value;
            });
          },
        ),
      ),
    );
  }
}
