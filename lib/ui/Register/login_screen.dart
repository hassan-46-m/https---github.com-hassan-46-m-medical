import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intelligent_medical_system/ui/Home/home_screen.dart';
import 'package:intelligent_medical_system/ui/Register/signup_screen.dart';
import '../colors/app_colors.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = "Login Screen";

  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController(text: '');
  final TextEditingController _passwordController = TextEditingController(text: "");
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> _login() async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      Navigator.pushReplacementNamed(context, HomeScreen.routeName);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Login failed: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: AppColor.whiteColor),
        toolbarHeight: 28,
        backgroundColor: AppColor.primaryColor,
      ),
      backgroundColor: AppColor.primaryColor,
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          margin: EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Welcome back,",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColor.whiteColor,
                  fontSize: 27,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                "Log in to get started",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColor.whiteColor,
                  fontSize: 27,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 20),
              Image.asset(
                "assets/images/logo.png",
                width: 200,
                height: 180,
              ),
              SizedBox(height: 20),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  hintText: "Username, email or mobile number",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
              SizedBox(height: 50),
              TextField(
                controller: _passwordController,
                decoration: InputDecoration(
                  hintText: "Password",
                  suffixIcon: Icon(Icons.visibility_off_outlined),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
                obscureText: true,
              ),
              SizedBox(height: 40),
              ElevatedButton(
                onPressed: _login,
                child: Text("Log in"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColor.secondColor,
                  foregroundColor: AppColor.whiteColor,
                  textStyle: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w700,
                  ),
                  fixedSize: Size(250, 50),
                ),
              ),
              SizedBox(height: 20),
              Text(
                "Don’t have an account?",
                style: TextStyle(color: Colors.grey),
              ),
              OutlinedButton(
                onPressed: () {
                  Navigator.pushNamed(context, SignupScreen.routeName);
                },
                child: Text("Create new account"),
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColor.whiteColor,
                  side: BorderSide(color: AppColor.secondColor),
                  textStyle: TextStyle(
                    fontSize: 15,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
