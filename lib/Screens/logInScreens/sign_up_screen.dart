import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instaclone/Screens/logInScreens/logInScreen.dart';
import 'package:instaclone/resources/auth_method.dart';
import 'package:instaclone/utils/assets.dart';
import 'package:instaclone/utils/colors.dart';
import 'package:instaclone/utils/utils.dart';
import 'package:instaclone/widget/text_field.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _userNameController = TextEditingController();
  Uint8List? image;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _bioController.dispose();
    _userNameController.dispose();
  }

  void selectImage() async {
    Uint8List? im = await pickImage(ImageSource.gallery);
    setState(() {
      image = im;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        width: double.infinity,
        child: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            Image.asset(
              instatxt,
              color: PrimaryColor,
              height: 64,
            ),
            const SizedBox(
              height: 64,
            ),
            Stack(
              children: [
                image != null
                    ? CircleAvatar(
                        radius: 64,
                        backgroundColor: Colors.red,
                        backgroundImage: MemoryImage(image!),
                      )
                    : CircleAvatar(
                        radius: 64,
                        backgroundColor: Colors.grey.withOpacity(.5),
                        child: const Icon(
                          Icons.person,
                          size: 120,
                        ),
                      ),
                Positioned(
                    bottom: 8,
                    right: 8,
                    child: GestureDetector(
                        onTap: selectImage,
                        child: const Icon(Icons.add_a_photo)))
              ],
            ),
            const SizedBox(
              height: 24,
            ),
            TextFieldinput(
                controller: _userNameController,
                hintText: "Enter your user name",
                textInputType: TextInputType.emailAddress),
            const SizedBox(
              height: 24,
            ),
            TextFieldinput(
              controller: _emailController,
              hintText: "Enter your email",
              textInputType: TextInputType.text,
            ),
            const SizedBox(
              height: 24,
            ),
            TextFieldinput(
              controller: _passwordController,
              hintText: "Enter your Password",
              textInputType: TextInputType.text,
            ),
            const SizedBox(
              height: 24,
            ),
            TextFieldinput(
              controller: _bioController,
              hintText: "Enter your Bio",
              textInputType: TextInputType.text,
            ),
            const SizedBox(
              height: 24,
            ),
            GestureDetector(
              onTap: () async {
                log('aaya ${_userNameController.text}');
                String res = await AuthMethods().signUpUser(
                  _emailController.text,
                  _passwordController.text,
                  _userNameController.text,
                  _bioController.text,
                  //  image!,
                );
                if (res == "Success") {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LogInScreen()));
                } else {
                  log(res);
                }
              },
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 12),
                alignment: Alignment.center,
                decoration: ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  color: blueColor,
                ),
                child: const Text("Sign Up"),
              ),
            ),
            const SizedBox(
              height: 12,
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
                  onTap: () async {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => LogInScreen()));
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: const Text(
                      "Log in",
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
      ),
    ));
  }
}
