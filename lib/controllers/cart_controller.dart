import 'package:emart/consts/app_consts.dart';

import '../models/test_model.dart';

class CartController extends GetxController {
  var totalPrice = 0.0.obs;
  var selectedPaymentIndex = 0.obs;

  calculateTotalPrice({required List<TestModel> items}) {
    totalPrice.value = 0;
    for (var e in items) {
      totalPrice.value = totalPrice.value + e.totalPrice;
    }
  }
}
