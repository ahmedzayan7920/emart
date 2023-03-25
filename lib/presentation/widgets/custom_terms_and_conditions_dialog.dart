import 'package:emart/presentation/widgets/custom_button.dart';

import '../../consts/app_consts.dart';

class CustomTermsAndConditionsDialog extends StatelessWidget {
  const CustomTermsAndConditionsDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            "Terms and Conditions"
                .text
                .fontFamily(AppStyles.bold)
                .size(18)
                .color(AppColors.darkFontGrey)
                .make(),
            10.heightBox,
            """
Welcome to Ennovation, an ecommerce app that enables you to buy and sell products online. By using our app, you agree to be bound by the following terms and conditions:

1-   Eligibility: To use Ennovation, you must be at least 18 years old or have the consent of a parent or legal guardian. You must also be legally capable of entering into a binding contract.

2-   User Account: To use our app, you must create an account by providing accurate and complete information. You are responsible for maintaining the confidentiality of your account and password, and for any activities that occur under your account.

3-   Payment: All payments made through Ennovation are processed securely through our third-party payment provider. We do not store your payment information on our servers.

4-   User Conduct: You agree not to use Ennovation for any illegal or unauthorized purpose. You also agree not to post any content that is defamatory, obscene, or infringes on the intellectual property rights of others.

5-   Liability: Ennovation is not liable for any damages or losses arising from the use of our app. We are also not responsible for any disputes between users or between users and third-party sellers.

6-   Termination: We reserve the right to terminate your account or restrict your access to our app at any time, for any reason.

7-   Modifications: We may modify these terms and conditions at any time, without notice. By continuing to use Ennovation, you agree to be bound by the updated terms and conditions.
            """
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
