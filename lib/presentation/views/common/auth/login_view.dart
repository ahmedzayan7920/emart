import 'package:emart/presentation/views/common/auth/forget_password_view.dart';
import 'package:emart/presentation/widgets/custom_app_logo.dart';
import 'package:emart/presentation/widgets/custom_button.dart';

import '../../../../consts/app_consts.dart';
import '../../../../controllers/auth_controller.dart';
import '../../../widgets/custom_background.dart';
import '../../../widgets/custom_text_field.dart';
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

  final formKey = GlobalKey<FormState>();

  login() {

    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      FocusManager.instance.primaryFocus?.unfocus();
      controller.login(
        email: emailController.text,
        password: passwordController.text,
        context: context,
      );
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
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
                "Login to ${AppStrings.appName}".text.white.fontFamily(AppStyles.bold).size(18).make(),
                15.heightBox,
                Column(
                  children: [
                    Form(
                      key: formKey,
                      child: Column(
                        children: [
                          CustomTextField(
                            title: AppStrings.email,
                            hint: AppStrings.emailHint,
                            controller: emailController,
                            keyboardType: TextInputType.emailAddress,
                          ),
                          10.heightBox,
                          CustomTextField(
                            title: AppStrings.password,
                            hint: AppStrings.passwordHint,
                            controller: passwordController,
                            isPassword: true,
                          ),
                        ],
                      ),
                    ),
                    Align(
                      alignment: AlignmentDirectional.centerEnd,
                      child: TextButton(
                        onPressed: () {
                          Get.to(()=> const ForgetPasswordView());
                        },
                        child: AppStrings.forgetPassword.text.fontFamily(AppStyles.semiBold).make(),
                      ),
                    ),
                    Obx(
                      () => controller.isLoading.value
                          ? const Center(child: CircularProgressIndicator())
                          : CustomButton(
                              onPressed: login,
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
