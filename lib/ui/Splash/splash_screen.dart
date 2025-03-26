import 'package:flutter/material.dart';
import 'package:intelligent_medical_system/ui/Register/login_screen.dart';
import 'package:intelligent_medical_system/ui/Register/signup_screen.dart';
import 'package:intelligent_medical_system/ui/custom/custom_btn.dart';

import '../colors/app_colors.dart';

class SplashScreen extends StatefulWidget {
  static const String routeName = "Splash Screen";

  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Intelligent",
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 40,
                      color: AppColor.secondColor),
                ),
                Text(
                  "Medical System",
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 40,
                      color: AppColor.whiteColor),
                ),
              ],
            ),
            const SizedBox(height: 30),
            Expanded(
              child: Center(
                child: Image.asset(
                  "assets/images/logo.png",
                  width: 250, // التحكم في حجم الصورة
                ),
              ),
            ),
            const SizedBox(height: 30),
            CustomBtn(
              doThis: goToLogin,
              textSize: 22,
              textWeight: FontWeight.w500,
              btnText: "Login",
              btnTextColor: AppColor.whiteColor,
              btnWidth: double.infinity, // زر بالحجم الكامل
              btnColor: AppColor.secondColor,
              btnBorderWidth: 0,
              btnBorderColor: Colors.transparent,
            ),
            const SizedBox(height: 20),
            CustomBtn(
              doThis: goToSignUp,
              textSize: 22,
              textWeight: FontWeight.w500,
              btnText: "Sign Up",
              btnTextColor: AppColor.darkColor,
              btnWidth: double.infinity, // زر بالحجم الكامل
              btnColor: AppColor.whiteColor,
              btnBorderWidth: 3,
              btnBorderColor: AppColor.secondColor,
            ),
          ],
        ),
      ),
    );
  }

  void goToLogin() {
    Navigator.pushReplacementNamed(context, LoginScreen.routeName);
  }

  void goToSignUp() {
    Navigator.pushReplacementNamed(context, SignupScreen.routeName);
  }
}
