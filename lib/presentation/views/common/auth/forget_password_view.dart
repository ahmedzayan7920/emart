import 'package:emart/presentation/widgets/custom_app_logo.dart';
import 'package:emart/presentation/widgets/custom_button.dart';

import '../../../../consts/app_consts.dart';
import '../../../../controllers/auth_controller.dart';
import '../../../widgets/custom_background.dart';
import '../../../widgets/custom_text_field.dart';

class ForgetPasswordView extends StatefulWidget {
  const ForgetPasswordView({Key? key}) : super(key: key);

  @override
  State<ForgetPasswordView> createState() => _ForgetPasswordViewState();
}

class _ForgetPasswordViewState extends State<ForgetPasswordView> {
  final emailController = TextEditingController();

  var controller = Get.put(AuthController());

  final formKey = GlobalKey<FormState>();

  resetPassword() {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      FocusManager.instance.primaryFocus?.unfocus();
      controller.resetPassword(context: context, email: emailController.text);
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomBackground(
      child: Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Center(
            child: Column(
              children: [
                // (context.screenHeight * 0.1).heightBox,
                const CustomAppLogo(),
                15.heightBox,
                "Reset Password".text.white.fontFamily(AppStyles.bold).size(18).make(),
                15.heightBox,
                Column(
                  children: [
                    Form(
                      key: formKey,
                      child: CustomTextField(
                        title: AppStrings.email,
                        hint: AppStrings.emailHint,
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                      ),
                    ),
                    12.heightBox,
                    Obx(
                      () => controller.isLoading.value
                          ? const Center(child: CircularProgressIndicator())
                          : CustomButton(
                              onPressed: resetPassword,
                              text: AppStrings.login,
                            ),
                    ),
                  ],
                )
                    .box
                    .white
                    .rounded
                    .padding(const EdgeInsets.all(16))
                    .width(context.screenWidth - 70)
                    .shadowSm
                    .make(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
