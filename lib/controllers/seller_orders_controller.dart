import 'package:emart/consts/app_consts.dart';

class SellerOrdersController extends GetxController{
  var isLoading = false.obs;

  changeOrderStatus({required String id, required String status}) async {
    isLoading(true);
    await AppFirebase.firestore.collection(AppFirebase.ordersCollection).doc(id).update({
      status: true,
    });
    isLoading(false);
  }
}