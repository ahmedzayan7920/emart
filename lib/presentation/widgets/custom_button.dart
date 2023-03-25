import '../../consts/app_consts.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    Key? key,
    required this.onPressed,
    required this.text,
    this.color = AppColors.redColor,
    this.textColor = AppColors.whiteColor,
  }) : super(key: key);
  final void Function()? onPressed;
  final String text;
  final Color color;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
      ),
      child: text.text.color(textColor).fontFamily(AppStyles.bold).make(),
    ).box.width(context.screenWidth).make();
  }
}
