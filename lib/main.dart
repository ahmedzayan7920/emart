import 'package:emart/views/splash/splash_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';

import 'consts/app_consts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: AppStrings.appName,
      theme: ThemeData(
        primaryColor: AppColors.redColor,
        colorScheme: const ColorScheme.light(
          primary: AppColors.redColor,
          secondary: AppColors.redColor,
          onBackground: AppColors.redColor,
          inversePrimary: AppColors.redColor,
        ),
        scaffoldBackgroundColor: Colors.transparent,
        appBarTheme: const AppBarTheme(
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarIconBrightness: Brightness.dark,
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          iconTheme: IconThemeData(
            color: AppColors.darkFontGrey,
          ),
        ),
        fontFamily: AppStyles.regular,
      ),
      home: const SplashView(),
    );
  }
}
