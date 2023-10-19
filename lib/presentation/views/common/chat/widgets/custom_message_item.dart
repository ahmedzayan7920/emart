import 'package:intl/intl.dart' as intl;

import '../../../../../consts/app_consts.dart';
import '../../../../../models/message_model.dart';

class CustomMessageItem extends StatelessWidget {
  const CustomMessageItem({Key? key, required this.message}) : super(key: key);

  final MessageModel message;

  @override
  Widget build(BuildContext context) {
    return message.senderId == AppFirebase.currentUser!.uid
        ? Align(
            alignment: AlignmentDirectional.centerEnd,
            child: Container(
              padding: const EdgeInsets.all(12),
              margin: const EdgeInsets.all(8),
              width: context.screenWidth - 100,
              decoration: const BoxDecoration(
                color: AppColors.redColor,
                borderRadius: BorderRadiusDirectional.only(
                  topEnd: Radius.circular(20),
                  topStart: Radius.circular(20),
                  bottomStart: Radius.circular(20),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  message.message.text.white.size(16).start.make(),
                  10.heightBox,
                  (intl.DateFormat("hh:mm a").format(DateTime.fromMillisecondsSinceEpoch(message.time)))
                      .text
                      .color(AppColors.whiteColor.withOpacity(0.5))
                      .size(16)
                      .end
                      .make(),
                ],
              ),
            ),
          )
        : Align(
            alignment: AlignmentDirectional.centerStart,
            child: Container(
              padding: const EdgeInsets.all(12),
              margin: const EdgeInsets.all(8),
              width: context.screenWidth - 100,
              decoration: const BoxDecoration(
                color: AppColors.darkFontGrey,
                borderRadius: BorderRadiusDirectional.only(
                  topEnd: Radius.circular(20),
                  topStart: Radius.circular(20),
                  bottomEnd: Radius.circular(20),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  message.message.text.white.size(16).start.make(),
                  10.heightBox,
                  (intl.DateFormat("hh:mm a").format(DateTime.fromMillisecondsSinceEpoch(message.time)))
                      .text
                      .color(AppColors.whiteColor.withOpacity(0.5))
                      .size(16)
                      .end
                      .make(),
                ],
              ),
            ),
          );
  }
}
