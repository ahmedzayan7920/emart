// ignore_for_file: use_build_context_synchronously

import 'package:emart/consts/app_consts.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class SellerOrdersController extends GetxController {
  var isLoading = false.obs;

  changeOrderStatus({required String id, required String status, required BuildContext context}) async {
    isLoading(true);
    if (await InternetConnectionChecker().hasConnection) {
      await AppFirebase.firestore.collection(AppFirebase.ordersCollection).doc(id).update({
        status: true,
      });
    } else {
      VxToast.show(context, msg: "No Internet Connection");
    }
    isLoading(false);
  }
}
