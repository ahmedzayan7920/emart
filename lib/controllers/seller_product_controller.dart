import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart/consts/app_consts.dart';
import 'package:emart/models/address_model.dart';
import 'package:emart/models/order_model.dart';
import 'package:emart/views/orders/orders_view.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

import '../models/category_model.dart';
import '../models/product_model.dart';
import '../services/firestore_services.dart';

class SellerProductController extends GetxController {
  /// Products View
  final menuController = VxPopupMenuController();


  changeFeaturedStatus({required String id, required bool isFeatured}) async {
    await AppFirebase.firestore.collection(AppFirebase.productsCollection).doc(id).update({
      "isFeatured": !isFeatured,
    });
  }

  deleteProduct({required ProductModel product}) async {
    await AppFirebase.firestore.collection(AppFirebase.productsCollection).doc(product.id).delete();
    for (var url in product.images) {
      FirebaseStorage.instance.refFromURL(url).delete();
    }
  }

  /// Add, Edit Product View

  final formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  final priceController = TextEditingController();
  final shippingPriceController = TextEditingController();
  final quantityController = TextEditingController();

  var categoryValue = "".obs;
  var subCategoryValue = "".obs;

  RxList<String> categories = <String>[].obs;
  RxList<String> subCategories = <String>[].obs;

  getCategories() async {
    categories.clear();
    final data = await rootBundle.loadString("assets/categories.json");
    CategoryModel categoryModel = CategoryModel.fromJson(json.decode(data));
    for (var x in categoryModel.categories!) {
      categories.add(x.name!);
    }
  }

  getSubCategories({required String category}) async {
    subCategories.clear();
    final data = await rootBundle.loadString("assets/categories.json");
    CategoryModel categoryModel = CategoryModel.fromJson(json.decode(data));
    for (var x in categoryModel.categories!) {
      if (x.name == category) {
        subCategories.value = x.subCategories!;
      }
    }
  }

  var images = <File?>[null, null, null].obs;
  List<String?> imagesUrl = [null, null, null];

  pickImage({required int index}) async {
    final pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery, imageQuality: 70);
    if (pickedImage == null) return;
    images[index] = File(pickedImage.path);
  }

  uploadImages() async {
    for (var i = 0; i < images.length; i++) {
      if (images[i] != null) {
        var fileName = basename(images[i]!.path);
        final ref =
            FirebaseStorage.instance.ref("products").child("${AppFirebase.currentUser!.uid}/$fileName");
        await ref.putFile(File(images[i]!.path));
        imagesUrl[i] = await ref.getDownloadURL();
      }
    }
    for (var i = 0; i < images.length; i++) {
      imagesUrl.remove(null);
    }
  }

  var selectedColors = <int>[0].obs;
  var isUploading = false.obs;

  uploadProduct({required BuildContext context}) async {
    isUploading(true);
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      if (categoryValue.isNotEmpty && subCategoryValue.isNotEmpty) {
        if (images.count((element) => element != null) > 0) {
          if (selectedColors.isNotEmpty) {
            await uploadImages();
            List<String> images = [];
            for (var e in imagesUrl) {
              if (e != null) {
                images.add(e);
              }
            }
            final colors = selectedColors.map((element) => Colors.primaries[element].value).toList();
            final ref = AppFirebase.firestore.collection(AppFirebase.productsCollection).doc();
            ProductModel productModel = ProductModel(
              id: ref.id,
              name: nameController.text,
              category: categoryValue.value,
              subCategory: subCategoryValue.value,
              description: descriptionController.text,
              price: num.parse(priceController.text),
              shippingPrice: num.parse(shippingPriceController.text),
              quantity: num.parse(quantityController.text),
              colors: colors,
              images: images,
              wishlist: [],
              seller: AppFirebase.currentUser!.displayName!,
              sellerId: AppFirebase.currentUser!.uid,
              isFeatured: false,
            );
            await ref.set(productModel.toMap());
            Get.back();
          } else {
            VxToast.show(context, msg: "Select 1 Color at least for the Product");
          }
        } else {
          VxToast.show(context, msg: "Select 1 Image at least for the Product");
        }
      } else {
        VxToast.show(context, msg: "Select Category and Sub Category for the Product");
      }
    }
    isUploading(false);
    imagesUrl = [null, null, null];
  }

  updateProduct({required BuildContext context, required ProductModel product}) async {
    isUploading(true);
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      if (categoryValue.isNotEmpty && subCategoryValue.isNotEmpty) {
        if (selectedColors.isNotEmpty) {
          if (images.count((element) => element != null) > 0) {
            await uploadImages();
            List<String> images = [];
            for (var e in imagesUrl) {
              if (e != null) {
                images.add(e);
              }
            }
            final colors = selectedColors.map((element) => Colors.primaries[element].value).toList();
            ProductModel productModel = ProductModel(
              id: product.id,
              name: nameController.text,
              category: categoryValue.value,
              subCategory: subCategoryValue.value,
              description: descriptionController.text,
              price: num.parse(priceController.text),
              shippingPrice: num.parse(shippingPriceController.text),
              quantity: num.parse(quantityController.text),
              colors: colors,
              images: images,
              wishlist: product.wishlist,
              seller: AppFirebase.currentUser!.displayName!,
              sellerId: AppFirebase.currentUser!.uid,
              isFeatured: product.isFeatured,
            );
            await AppFirebase.firestore.collection(AppFirebase.productsCollection).doc(product.id).update(productModel.toMap());
            Get.back();
          } else {
            List<String> images = [];
            for (var e in imagesUrl) {
              if (e != null) {
                images.add(e);
              }
            }
            final colors = selectedColors.map((element) => Colors.primaries[element].value).toList();
            ProductModel productModel = ProductModel(
              id: product.id,
              name: nameController.text,
              category: categoryValue.value,
              subCategory: subCategoryValue.value,
              description: descriptionController.text,
              price: num.parse(priceController.text),
              shippingPrice: num.parse(shippingPriceController.text),
              quantity: num.parse(quantityController.text),
              colors: colors,
              images: images,
              wishlist: product.wishlist,
              seller: AppFirebase.currentUser!.displayName!,
              sellerId: AppFirebase.currentUser!.uid,
              isFeatured: product.isFeatured,
            );
            await AppFirebase.firestore.collection(AppFirebase.productsCollection).doc(product.id).update(productModel.toMap());
            Get.back();
          }
        } else {
          VxToast.show(context, msg: "Select 1 Color at least for the Product");
        }
      } else {
        VxToast.show(context, msg: "Select Category and Sub Category for the Product");
      }
    }
    isUploading(false);
    imagesUrl = [null, null, null];
  }

  @override
  void onInit() async {
    await getCategories();
    super.onInit();
  }

  @override
  void onClose() {
    menuController.dispose();
    nameController.dispose();
    descriptionController.dispose();
    priceController.dispose();
    shippingPriceController.dispose();
    quantityController.dispose();
    super.onClose();
  }
}
