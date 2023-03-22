import 'dart:convert';

import 'package:emart/consts/app_consts.dart';
import 'package:emart/models/category_model.dart';
import 'package:flutter/services.dart';

class CategoryController extends GetxController {
  List<String> subCategories = [];

  getSubCategories({required String title}) async {
    final data = await rootBundle.loadString("assets/categories.json");
    CategoryModel categoryModel = CategoryModel.fromJson(json.decode(data));
    for (var x in categoryModel.categories!) {
      if (x.name == title) {
        subCategories = x.subCategories!;
      }
    }
  }
}
