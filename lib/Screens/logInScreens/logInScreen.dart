import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:instaclone/Screens/logInScreens/sign_up_screen.dart';
import 'package:instaclone/resources/auth_method.dart';
import 'package:instaclone/utils/assets.dart';
import 'package:instaclone/utils/colors.dart';
import 'package:instaclone/widget/text_field.dart';

import '../../responsive/mobileScreenLayout.dart';
import '../../responsive/responsiveLayout.dart';
import '../../responsive/webScreenLayout.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void loginguser() async {
    String res = await AuthMethods()
        .logInUser(_emailController.text, _passwordController.text);
    if (res == " Success ") {
      // next step
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => const ResponsiveLayout(
                  webScreenLayout: WebScreenLayout(),
                  mobileScreenLayout: MobileScreenLayout())));
      log("loggedin");
    } else {
      // snakbar
      log("error");
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        width: double.infinity,
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          Flexible(
            child: Container(),
            flex: 2,
          ),
          Image.asset(
            instatxt,
            color: PrimaryColor,
            height: 64,
          ),
          const SizedBox(
            height: 64,
          ),
          TextFieldinput(
              controller: _emailController,
              hintText: "Enter your Email",
              textInputType: TextInputType.emailAddress),
          const SizedBox(
            height: 24,
          ),
          TextFieldinput(
            controller: _passwordController,
            hintText: "Enter your password",
            textInputType: TextInputType.text,
            isPass: true,
          ),
          const SizedBox(
            height: 24,
          ),
          GestureDetector(
            onTap: loginguser,
            child: Container(
              child: const Text("LogIn"),
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 12),
              alignment: Alignment.center,
              decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                color: blueColor,
              ),
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          Flexible(
            child: Container(),
            flex: 2,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: const Text(
                  "Dont't have an account?",
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SignUpScreen()));
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: const Text(
                    "Sign Up",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          )
        ]),
      ),
    ));
  }
}
