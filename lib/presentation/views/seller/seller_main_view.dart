import 'package:emart/presentation/views/seller/product/seller_add_product_view.dart';

import '../../../consts/app_consts.dart';
import '../../widgets/custom_exit_dialog.dart';
import 'order/seller_orders_view.dart';
import 'product/seller_products_view.dart';
import 'settings/seller_settings_view.dart';

class SellerMainView extends StatefulWidget {
  const SellerMainView({Key? key}) : super(key: key);

  @override
  State<SellerMainView> createState() => _SellerMainViewState();
}

class _SellerMainViewState extends State<SellerMainView> {
  var currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    var bodyItems = [
      const SellerProductsView(),
      const SellerOrdersView(),
      const SellerSettingsView(),
    ];

    var navItems = [
      BottomNavigationBarItem(
        icon: Image.asset(
          AppImages.icProducts,
          width: 26,
          color: currentIndex == 0 ? AppColors.redColor : Colors.grey,
        ),
        label: AppStrings.products,
      ),
      BottomNavigationBarItem(
        icon: Image.asset(
          AppImages.icOrders,
          width: 26,
          color: currentIndex == 1 ? AppColors.redColor : Colors.grey,
        ),
        label: AppStrings.orders,
      ),
      BottomNavigationBarItem(
        icon: Image.asset(
          AppImages.icGeneralSettings,
          width: 26,
          color: currentIndex == 2 ? AppColors.redColor : Colors.grey,
        ),
        label: AppStrings.settings,
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
        floatingActionButton: currentIndex == 0
            ? FloatingActionButton(
                onPressed: () {
                  Get.to(()=> const SellerAddProductView());
                },
                child: const Icon(Icons.add, color: Colors.white),
              )
            : null,
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
