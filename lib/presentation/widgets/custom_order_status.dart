import '../../consts/app_consts.dart';

class CustomOrderStatus extends StatelessWidget {
  const CustomOrderStatus({
    Key? key,
    required this.title,
    required this.isDone,
  }) : super(key: key);

  final String title;
  final bool isDone;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      minLeadingWidth: 0,
      leading: Icon(
        isDone ? Icons.done : null,
        color: AppColors.redColor,
      ),
      title: Row(
        children: [
          Expanded(
            child: Divider(
              thickness: 1.5,
              color: isDone ? AppColors.redColor : null,
            ),
          ),
          5.widthBox,
          title.text.color(AppColors.darkFontGrey).fontFamily(AppStyles.semiBold).make(),
          5.widthBox,
          Expanded(
            child: Divider(
              thickness: 1.5,
              color: isDone ? AppColors.redColor : null,
            ),
          ),
        ],
      ),
      trailing: Icon(
        isDone ? Icons.done : null,
        color: AppColors.redColor,
      ),
    );
  }
}
