import '../../../consts/app_consts.dart';

class CustomFeaturedButton extends StatelessWidget {
  const CustomFeaturedButton({Key? key, required this.title, required this.image}) : super(key: key);
  final String title;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(
          image,
          height: 60,
          fit: BoxFit.fill,
        ),
        10.widthBox,
        title.text
            .color(AppColors.darkFontGrey)
            .fontFamily(AppStyles.semiBold)
            .ellipsis
            .make(),
      ],
    ).box.width(200).white.padding(const EdgeInsets.all(4)).roundedSM.outerShadowSm.make();
  }
}
