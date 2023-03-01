import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';

class StorageMethods {
  final FirebaseStorage firebaseStorage = FirebaseStorage.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // adding images to filebase Storage

  Future<String> uploadImageTostore(
      String childName, Uint8List file, bool isPost) async {
    Reference ref =
        firebaseStorage.ref().child(childName).child(_auth.currentUser!.uid);
    log('ref is :- $ref');
    UploadTask uploadTask = ref.putData(file);
    log("uploadTask is :-  $uploadTask");
    TaskSnapshot taskSnapshot = await uploadTask;
    log("tasksnapshot :- $taskSnapshot");

    String imageUrl = await taskSnapshot.ref.getDownloadURL();
    return imageUrl;
  }
}
