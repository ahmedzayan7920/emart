import '../../consts/app_consts.dart';

class CustomHomeButton extends StatelessWidget {
  const CustomHomeButton({super.key, required this.title, required this.imagePath, required this.height,});

  final String title;
  final String imagePath;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            imagePath,
            width: 26,
          ),
          10.heightBox,
          title.text.fontFamily(AppStyles.semiBold).color(AppColors.darkFontGrey).center.make(),
        ],
      ).box.white.rounded.height(height).shadowSm.make(),
    );
  }
}
