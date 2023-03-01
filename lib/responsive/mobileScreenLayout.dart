import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:instaclone/models/user_model.dart';
import 'package:instaclone/provider/user_provider.dart';
import 'package:instaclone/utils/colors.dart';
import 'package:provider/provider.dart';

class MobileScreenLayout extends StatelessWidget {
  const MobileScreenLayout({super.key});

  @override
  Widget build(BuildContext context) {
    UserModel? userModel = Provider.of<UserProvider>(context).getUserData;
    log("model is :- $userModel");
    return Scaffold(
      body: Center(
          child: userModel == null
              ? const CircularProgressIndicator(
                  color: PrimaryColor,
                )
              : Text('${userModel.email}')),
    );
  }
}
