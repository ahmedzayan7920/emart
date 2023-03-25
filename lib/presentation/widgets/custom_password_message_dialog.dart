import '../../consts/app_consts.dart';
import 'custom_button.dart';

class CustomPasswordMessageDialog extends StatelessWidget {
  const CustomPasswordMessageDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          """A message has been sent to your registered email address with instructions on how to reset your password. Please check your email."""
              .text
              .size(16)
              .color(AppColors.darkFontGrey)
              .make(),
          10.heightBox,
          Align(
            alignment: AlignmentDirectional.centerEnd,
            child: CustomButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
              text: "Ok",
            ).box.width(80).make(),
          ),
        ],
      ).box.padding(const EdgeInsets.all(16)).rounded.make(),
    );
  }
}
