import 'package:clone_of_instagram/resources/storage_methods.dart';
import 'package:flutter/material.dart';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // sign up user
  Future<String> signUpUser({
    required String email,
    required String password,
    required String username,
    required String bio,
    required Uint8List file,
  }) async {
    String res = "Some error occurred";
    try {
      if (email.isNotEmpty ||
          password.isNotEmpty ||
          username.isNotEmpty ||
          bio.isNotEmpty||
          file != null
      ) {
        // ユーザーを登録する
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);

        String photoUrl = await StorageMethods().uploadImageToStorage('ProfilePics', file, false);


        await _firestore.collection('users').doc(cred.user!.uid).set({
          'username': username,
          'uid': cred.user!.uid,
          'email': email,
          'bio': bio,
          'followers':[],
          'following':[],
          'photoUrl':photoUrl,

        });

        res = "success";
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }
}
