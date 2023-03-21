import '../../../consts/app_consts.dart';

class CustomDetailsRow extends StatelessWidget {
  const CustomDetailsRow({
    super.key,
    required this.title1,
    required this.title2,
    required this.detail1,
    required this.detail2,
    this.color1 = Colors.grey,
    this.color2 = Colors.grey,
  });

  final String title1;
  final String title2;
  final String detail1;
  final String detail2;
  final Color color1;
  final Color color2;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              title1.text.color(AppColors.darkFontGrey).fontFamily(AppStyles.semiBold).size(16).make(),
              detail1.text.color(color1).make(),
            ],
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              title2.text.color(AppColors.darkFontGrey).fontFamily(AppStyles.semiBold).size(16).make(),
              detail2.text.color(color2).make(),
            ],
          ),
        ),
      ],
    );
  }
}
