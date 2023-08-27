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
    } on FirebaseAuthException catch(err){
      if(err.code == 'invalid-email'){
        res = '有効なメールアドレスではありません。';
      }else if(err.code == 'weak-password'){
        res = 'パスワードが短すぎます。';
      }

    }

    catch (err) {
      res = err.toString();
    }
    return res;
  }

  Future<String> loginUser({
    required String email,
    required String password
  }) async {
    String res = "Some error";

    try{

      if(email.isNotEmpty || password.isNotEmpty){

        await _auth.signInWithEmailAndPassword(email: email, password: password);

        res = "success";
      }else{
        res = "メールアドレスまたはパスワードが空です。";
      }
    } catch(err){
      res = err.toString();
    }
    return res;
  }

}
