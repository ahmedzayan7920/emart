import 'package:emart/controllers/auth_controller.dart';
import 'package:emart/presentation/widgets/custom_app_logo.dart';
import 'package:emart/presentation/widgets/custom_button.dart';
import 'package:flutter/gestures.dart';

import '../../../../consts/app_consts.dart';
import '../../../widgets/custom_background.dart';
import '../../../widgets/custom_privacy_policy_dialog.dart';
import '../../../widgets/custom_terms_and_conditions_dialog.dart';
import '../../../widgets/custom_text_field.dart';
import 'login_view.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({Key? key}) : super(key: key);

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final rePasswordController = TextEditingController();

  var controller = Get.put(AuthController());

  final formKey = GlobalKey<FormState>();

  signUp() {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      FocusManager.instance.primaryFocus?.unfocus();
      controller.signUp(
        name: nameController.text,
        email: emailController.text,
        password: passwordController.text,
        context: context,
      );
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    rePasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomBackground(
      child: Scaffold(
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Center(
            child: Column(
              children: [
                (context.screenHeight * 0.1).heightBox,
                const CustomAppLogo(),
                15.heightBox,
                "Join the ${AppStrings.appName}".text.white.fontFamily(AppStyles.bold).size(18).make(),
                15.heightBox,
                Column(
                  children: [
                    Form(
                      key: formKey,
                      child: Column(
                        children: [
                          CustomTextField(
                            title: AppStrings.name,
                            hint: AppStrings.nameHint,
                            controller: nameController,
                            keyboardType: TextInputType.emailAddress,
                          ),
                          10.heightBox,
                          CustomTextField(
                            title: AppStrings.email,
                            hint: AppStrings.emailHint,
                            controller: emailController,
                          ),
                          10.heightBox,
                          CustomTextField(
                            title: AppStrings.password,
                            hint: AppStrings.passwordHint,
                            controller: passwordController,
                            isPassword: true,
                          ),
                          10.heightBox,
                          CustomTextField(
                            title: AppStrings.rePassword,
                            hint: AppStrings.passwordHint,
                            controller: rePasswordController,
                            isPassword: true,
                          ),
                        ],
                      ),
                    ),
                    Obx(
                      () => Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          RadioMenuButton<bool>(
                            value: true,
                            groupValue: controller.isUser.value,
                            onChanged: (value) {
                              controller.isUser(true);
                            },
                            child: "User".text.make(),
                          ),
                          RadioMenuButton<bool>(
                            value: false,
                            groupValue: controller.isUser.value,
                            onChanged: (value) {
                              controller.isUser(false);
                            },
                            child: "Seller".text.make(),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Obx(
                          () => Checkbox(
                            value: controller.isTermsAgreed.value,
                            onChanged: (value) {
                              controller.isTermsAgreed(value ?? false);
                            },
                          ),
                        ),
                        18.widthBox,
                        Expanded(
                          child: RichText(
                            text: TextSpan(
                              children: [
                                const TextSpan(
                                  text: "I agree to the ",
                                  style: TextStyle(
                                    fontFamily: AppStyles.regular,
                                    color: AppColors.fontGrey,
                                  ),
                                ),
                                TextSpan(
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      showDialog(
                                        barrierDismissible: false,
                                        context: context,
                                        builder: (context) => const CustomTermsAndConditionsDialog(),
                                      );
                                    },
                                  text: AppStrings.termsAndConditions,
                                  style: const TextStyle(
                                    fontSize: 15,
                                    fontFamily: AppStyles.semiBold,
                                    color: AppColors.redColor,
                                    height: 1.5,
                                  ),
                                ),
                                const TextSpan(
                                  text: " & ",
                                  style: TextStyle(
                                    fontFamily: AppStyles.regular,
                                    color: AppColors.fontGrey,
                                  ),
                                ),
                                 TextSpan(
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      showDialog(
                                        barrierDismissible: false,
                                        context: context,
                                        builder: (context) => const CustomPrivacyPolicyDialog(),
                                      );
                                    },
                                  text: AppStrings.privacyPolicy,
                                  style: const TextStyle(
                                    fontSize: 15,
                                    fontFamily: AppStyles.semiBold,
                                    color: AppColors.redColor,
                                    height: 1.5,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Obx(
                      () => controller.isLoading.value
                          ? const Center(child: CircularProgressIndicator())
                          : CustomButton(
                              onPressed: controller.isTermsAgreed.value ? signUp : null,
                              text: AppStrings.signUp,
                            ),
                    ),
                    10.heightBox,
                    RichText(
                      text: TextSpan(
                        children: [
                          const TextSpan(
                            text: AppStrings.alreadyHaveAccount,
                            style: TextStyle(
                              fontFamily: AppStyles.semiBold,
                              color: AppColors.fontGrey,
                            ),
                          ),
                          TextSpan(
                            text: AppStrings.login,
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Get.off(() => const LoginView());
                              },
                            style: const TextStyle(
                              fontFamily: AppStyles.semiBold,
                              color: AppColors.redColor,
                            ),
                          ),
                        ],
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
