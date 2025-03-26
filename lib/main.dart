import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:intelligent_medical_system/ui/home/home_screen.dart';
import 'package:intelligent_medical_system/ui/Register/login_screen.dart';
import 'package:intelligent_medical_system/ui/Register/signup_screen.dart';
import 'package:intelligent_medical_system/ui/Splash/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      routes: {
        SplashScreen.routeName: (context) => SplashScreen(),
        HomeScreen.routeName: (context) => HomeScreen(),
        LoginScreen.routeName: (context) => LoginScreen(),
        SignupScreen.routeName: (context) => SignupScreen(),
      },
      debugShowCheckedModeBanner: false,
      initialRoute: SplashScreen.routeName,
    );
  }
}
