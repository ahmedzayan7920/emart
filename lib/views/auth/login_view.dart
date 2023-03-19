import 'package:emart/views/common/custom_app_logo.dart';
import 'package:emart/views/common/custom_background.dart';
import 'package:emart/views/common/custom_button.dart';
import 'package:emart/views/common/custom_text_field.dart';
import 'package:emart/views/main/main_view.dart';

import '../../consts/app_consts.dart';
import '../../controllers/auth_controller.dart';
import 'sign_up_view.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  var controller = Get.put(AuthController());

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
                "Login to ${AppStrings.appName}".text.white.fontFamily(AppStyles.bold).size(18).make(),
                15.heightBox,
                Column(
                  children: [
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
                    Align(
                      alignment: AlignmentDirectional.centerEnd,
                      child: TextButton(
                        onPressed: () {},
                        child: AppStrings.forgetPassword.text.fontFamily(AppStyles.semiBold).make(),
                      ),
                    ),
                    Obx(
                      () => controller.isLoading.value
                          ? const Center(child: CircularProgressIndicator())
                          : CustomButton(
                              onPressed: () {
                                controller.isLoading(true);
                                controller.login(
                                  email: emailController.text,
                                  password: passwordController.text,
                                  context: context,
                                );
                              },
                              text: AppStrings.login,
                            ),
                    ),
                    5.heightBox,
                    AppStrings.createNewAccount.text.color(AppColors.fontGrey).make(),
                    5.heightBox,
                    CustomButton(
                      onPressed: () {
                        Get.off(() => const SignUpView());
                      },
                      text: AppStrings.signUp,
                      color: AppColors.lightGolden,
                      textColor: AppColors.redColor,
                    ),
                    5.heightBox,
                    AppStrings.loginWith.text.color(AppColors.fontGrey).make(),
                    5.heightBox,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: AppLists.loginMethods
                          .map(
                            (e) => CircleAvatar(
                              radius: 25,
                              backgroundColor: AppColors.lightGrey,
                              child: Image.asset(e, width: 35),
                            ),
                          )
                          .toList(),
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
