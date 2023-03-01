import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String uid;
  final String userName;
  final String email;
  final String bio;
  //final String profilePic;
  final String password;
  final List followers;
  final List following;

  const UserModel({
    required this.bio,
    required this.email,
    required this.followers,
    required this.following,
    required this.password,
    required this.uid,
    required this.userName,
    // required this.profilePic,
  });

  Map<String, dynamic> toJson() => {
        "email": email,
        "password": password,
        "username": userName,
        "bio": bio,
        "u_id": uid,
        "followers": [],
        "following": [],
        // "ProfilePic": profilePic
      };

  static UserModel fromSnap(DocumentSnapshot shot) {
    var snapShot = shot.data() as Map<String, dynamic>;
    return UserModel(
      bio: snapShot['bio'],
      email: snapShot['email'],
      followers: snapShot['followers'],
      following: snapShot['following'],
      password: snapShot['password'],
      uid: snapShot['uid'],
      userName: snapShot['username'],
    );
  }
}
