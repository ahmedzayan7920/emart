import 'package:emart/presentation/widgets/custom_button.dart';

import '../../consts/app_consts.dart';

class CustomPrivacyPolicyDialog extends StatelessWidget {
  const CustomPrivacyPolicyDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            "Privacy Policy"
                .text
                .fontFamily(AppStyles.bold)
                .size(18)
                .color(AppColors.darkFontGrey)
                .make(),
            10.heightBox,
            """At Ennovation, we are committed to protecting your privacy. This privacy policy explains how we collect, use, and share your personal information:

1-   Information We Collect: When you use our app, we may collect information such as your name, email address, shipping address, and payment information. We may also collect information about your device, such as its operating system and IP address.

2-   How We Use Your Information: We use your information to process your orders, communicate with you about your purchases, and improve our app. We may also use your information to send you promotional emails or to personalize your experience on our app.

3-   Sharing Your Information: We do not sell or rent your personal information to third parties. We may share your information with our trusted partners who assist us in delivering our services.

4-   Security: We take reasonable measures to protect your information from unauthorized access or disclosure. However, we cannot guarantee the security of your information transmitted through the internet.

5-   Cookies: We may use cookies and similar technologies to collect information about your preferences and to personalize your experience on our app.

6-   Your Choices: You can opt-out of receiving promotional emails from us by following the instructions in the email. You can also disable cookies in your browser settings.

7-   Children's Privacy: We do not knowingly collect information from children under 13. If you believe we have collected information from a child, please contact us immediately."""
                .text
                .size(16)
                .color(AppColors.darkFontGrey)
                .make(),
            10.heightBox,
            Align(
              alignment: AlignmentDirectional.centerEnd,
              child: CustomButton(onPressed: (){
                Navigator.pop(context);
              }, text: "Ok",).box.width(80).make(),
            ),
          ],
        ).box.padding(const EdgeInsets.all(16)).rounded.make(),
      ),
    );
  }
}
