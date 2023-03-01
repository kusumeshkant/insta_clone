import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:instaclone/models/user_model.dart';
import 'package:instaclone/resources/auth_method.dart';

class UserProvider with ChangeNotifier {
  UserModel? _userModel;
  AuthMethods _authMethods = AuthMethods();

  UserModel? get getUserData => _userModel;

  Future<void> referUser() async {
    UserModel? userModel = await _authMethods.getUserData();
    _userModel = userModel;
    log("user model :- ${_userModel}");
    notifyListeners();
  }
}
