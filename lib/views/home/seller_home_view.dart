import '../../consts/app_consts.dart';

class SellerHomeView extends StatelessWidget {
  const SellerHomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.white,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              "Dashboard".text.fontFamily(AppStyles.semiBold).color(AppColors.darkFontGrey).size(18).make(),
              12.heightBox,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  CustomSellerHomeButton(title: "Products", count: 60, image: AppImages.icProducts),
                  CustomSellerHomeButton(title: "Orders", count: 15, image: AppImages.icOrders),
                ],
              ),
              12.heightBox,
              "Popular Products"
                  .text
                  .fontFamily(AppStyles.semiBold)
                  .color(AppColors.darkFontGrey)
                  .size(18)
                  .make(),
              Expanded(
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: 50,
                  itemBuilder: (context, index) {
                    return ListTile(
                      visualDensity: const VisualDensity(vertical: 4),
                      contentPadding: EdgeInsets.zero,
                      leading: Image.asset(AppImages.imgFc2, height: 100, width: 100, fit: BoxFit.cover,),
                      title: "Product Name".text.make(),
                      subtitle: "\$${400}".text.make(),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomSellerHomeButton extends StatelessWidget {
  const CustomSellerHomeButton({
    super.key,
    required this.title,
    required this.count,
    required this.image,
  });

  final String title;
  final int count;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            title.text.white.size(16).fontFamily(AppStyles.bold).make(),
            count.text.white.size(20).fontFamily(AppStyles.bold).make(),
          ],
        ),
        const Spacer(),
        Image.asset(
          image,
          width: 40,
          color: Colors.white,
        ),
      ],
    )
        .box
        .width((context.screenWidth - 48) / 2)
        .color(AppColors.redColor)
        .rounded
        .padding(const EdgeInsets.all(16))
        .make();
  }
}
