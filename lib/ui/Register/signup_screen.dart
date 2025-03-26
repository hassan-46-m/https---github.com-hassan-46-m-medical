import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intelligent_medical_system/ui/Register/login_screen.dart';
import '../colors/app_colors.dart';

class SignupScreen extends StatefulWidget {
  static const String routeName = "SignUp Screen";

  const SignupScreen({super.key});

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> _signup() async {
    if (_passwordController.text == _confirmPasswordController.text) {
      try {
        UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
          email: _emailController.text,
          password: _passwordController.text,
        );
        // Optionally, update the user's display name
        await userCredential.user?.updateDisplayName(_nameController.text);
        Navigator.pushReplacementNamed(context, LoginScreen.routeName);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Signup failed: $e')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Passwords do not match')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryColor,
      appBar: AppBar(
        iconTheme: IconThemeData(color: AppColor.whiteColor),
        toolbarHeight: 30,
        backgroundColor: AppColor.primaryColor,
      ),
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          margin: EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            children: [
              Text(
                'New To Us !',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColor.whiteColor,
                  fontSize: 27,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 70),
              TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  hintText: "Enter Your Name",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
              SizedBox(height: 15),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  hintText: "Enter Your Email",
                  suffixIcon: Icon(Icons.email_outlined, color: Colors.grey),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
              SizedBox(height: 15),
              TextField(
                controller: _passwordController,
                decoration: InputDecoration(
                  hintText: "Enter Your Password",
                  suffixIcon: Icon(Icons.visibility_outlined, color: Colors.grey),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
                obscureText: true,
              ),
              SizedBox(height: 15),
              TextField(
                controller: _confirmPasswordController,
                decoration: InputDecoration(
                  hintText: "Confirm Password",
                  suffixIcon: Icon(Icons.visibility_off_outlined, color: Colors.grey),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
                obscureText: true,
              ),
              SizedBox(height: 70),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have an account?",
                    style: TextStyle(fontSize: 15, color: AppColor.whiteColor),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pushReplacementNamed(context, LoginScreen.routeName);
                    },
                    child: Text(
                      " Log in",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: Colors.pink,
                      ),
                    ),
                  )
                ],
              ),
              ElevatedButton(
                onPressed: _signup,
                child: Text("Sign Up"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  foregroundColor: AppColor.whiteColor,
                  side: BorderSide(color: AppColor.secondColor),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
