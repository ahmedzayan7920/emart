import '../../../consts/app_consts.dart';

class CustomImageSlider extends StatelessWidget {
  const CustomImageSlider({
    super.key, required this.items,
  });

  final List<String> items;

  @override
  Widget build(BuildContext context) {
    return VxSwiper.builder(
      aspectRatio: 16 / 9,
      height: 150,
      autoPlay: true,
      enlargeCenterPage: true,
      enableInfiniteScroll: true,
      viewportFraction: 0.85,
      itemCount: items.length,
      itemBuilder: (context, index) {
        return Image.asset(
          items[index],
          fit: BoxFit.fill,
        )
            .box
            .rounded
            .clip(Clip.antiAlias)
            .margin(const EdgeInsets.symmetric(horizontal: 8))
            .make();
      },
    );
  }
}