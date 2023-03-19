import 'package:emart/views/common/custom_button.dart';
import 'package:flutter/services.dart';

import '../../consts/app_consts.dart';

class CustomExitDialog extends StatelessWidget {
  const CustomExitDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          "Confirm".text.fontFamily(AppStyles.bold).size(18).color(AppColors.darkFontGrey).make(),
          10.heightBox,
          "Are you sure you want to exit?".text.size(16).color(AppColors.darkFontGrey).make(),
          10.heightBox,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CustomButton(onPressed: (){
                SystemNavigator.pop();
              }, text: "Yes",).box.width(80).make(),
              CustomButton(onPressed: (){
                Navigator.pop(context);
              }, text: "No",).box.width(80).make(),
            ],
          ),
        ],
      ).box.color(AppColors.lightGrey).padding(const EdgeInsets.all(16)).rounded.make(),
    );
  }
}
