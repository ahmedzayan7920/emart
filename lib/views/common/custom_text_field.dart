import '../../consts/app_consts.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    Key? key,
    required this.title,
    required this.hint,
    required this.controller,
    this.isPassword = false,
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
          validator: (value) {
            if (value!.isEmpty) {
              return "$title Can't be Empty";
            }
            return null;
          },
          controller: controller,
          obscureText: isPassword,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
            hintText: hint,
            // isDense: true,
            fillColor: AppColors.lightGrey,
            filled: true,
            border: InputBorder.none,
            errorBorder: const OutlineInputBorder(
              gapPadding: 0,
              borderSide: BorderSide(
                color: AppColors.redColor,
              ),
            ),
            focusedErrorBorder: const OutlineInputBorder(
              gapPadding: 0,
              borderSide: BorderSide(
                color: AppColors.redColor,
              ),
            ),
            focusedBorder: const OutlineInputBorder(
              gapPadding: 0,
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
