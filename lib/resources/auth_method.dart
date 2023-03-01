import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:instaclone/models/user_model.dart';
import 'package:instaclone/resources/storage_method.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<UserModel> getUserData() async {
    User userModel = _auth.currentUser!;
    DocumentSnapshot documentSnapshot =
        await firestore.collection('user').doc(userModel.uid).get();
    return UserModel.fromSnap(documentSnapshot);
  }

  // Sign up user
  Future<String> signUpUser(
    String email,
    String password,
    String username,
    String bio,
    // Uint8List file
  ) async {
    String res = "Some Error occured";
    log("$email + $password + $username + $bio");
    try {
      if (email.isNotEmpty ||
              password.isNotEmpty ||
              username.isNotEmpty ||
              bio.isNotEmpty
          // ||
          // file != null
          ) {
        // String profilePic = await StorageMethods()
        //     .uploadImageTostore("ProfilePic", file, false);

        // regesting the user
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
        log("user ${cred.user!.uid}");
        UserModel userModel = UserModel(
          bio: bio,
          email: email,
          followers: [],
          following: [],
          password: password,
          uid: cred.user!.uid,
          userName: username,
          // profilePic: profilePic,
        );
        // adding user to firebase data base
        firestore.collection("user").doc(cred.user!.uid).set({
          "email": email,
          "password": password,
          "username": username,
          "bio": bio,
          "u_id": cred.user!.uid,
          "followers": [],
          "following": [],
          // "ProfilePic": profilePic
        });

        // anotherway to add
        // firestore.collection("user").add({
        //   "email": email,
        //   "password": password,
        //   "username": username,
        //   "bio": bio,
        //   "u_id": cred.user!.uid,
        //   "followers": [],
        //   "following": []
        // });
      }
      res = "Success";
    } on FirebaseAuthException catch (e) {
      res = e.toString();
      log(res);
    }
    return res;
  }

  // loggin user

  Future<String> logInUser(String email, String password) async {
    String res = "somthing went wrong";

    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        res = " Success ";
        log(res);
      } else {
        res = "please enter all the fields";
        log(res);
      }
    } catch (e) {
      res = e.toString();
    }
    return res;
  }
}
