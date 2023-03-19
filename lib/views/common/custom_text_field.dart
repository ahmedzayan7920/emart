import '../../consts/app_consts.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    Key? key,
    required this.title,
    required this.hint, required this.controller,  this.isPassword = false,
  }) : super(key: key);

  final String title;
  final String hint;
  final TextEditingController controller;
  final bool isPassword;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        title.text.color(AppColors.redColor).fontFamily(AppStyles.semiBold).size(16).make(),
        5.heightBox,
        TextFormField(
          // initialValue: controller.text,
          controller: controller,
          obscureText: isPassword,
          decoration:  InputDecoration(
            hintText: hint,
            // hintStyle: const TextStyle(color: AppColors.textFieldGrey),
            isDense: true,
            fillColor: AppColors.lightGrey,
            filled: true,
            border: InputBorder.none,
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: AppColors.redColor,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
