import '../../consts/app_consts.dart';

class CustomAppLogo extends StatelessWidget {
  const CustomAppLogo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(AppImages.icAppLogo)
        .box
        .white
        .size(75, 75)
        .padding(const EdgeInsets.all(8))
        .rounded
        .make();
  }
}
