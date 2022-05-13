import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:zoom_clone/utils/utils.dart';

class AuthMethods {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Stream<User?> get authChanges => _auth.authStateChanges();
  User get user => _auth.currentUser!;

  Future<bool> signInWithGoogle(BuildContext context) async {
    var res = false;
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      UserCredential userCredential =
          await _auth.signInWithCredential(credential);

      final User? user = userCredential.user;
      if (user != null) {
        var displayName = user.displayName!;
        var email = user.email!;
        var photoUrl = user.photoURL!;
        var uid = user.uid;

        var random = Random();
        String personalMeetingID =
            (random.nextInt(10000000) + 10000000).toString();

        if (userCredential.additionalUserInfo!.isNewUser) {
          await _firestore.collection('users').doc(user.uid).set({
            'username': user.displayName,
            'uid': user.uid,
            'email': user.email,
            'photoUrl': user.photoURL,
            'personalMeetingID': personalMeetingID,
          });
        } else {}

        // save to shared preferences
        addStringToSF("username", displayName);
        addStringToSF("email", email);
        addStringToSF("photoUrl", photoUrl);
        addStringToSF("uid", uid);
        addStringToSF("personalMeetingID", personalMeetingID);
      }
      res = true;
      return res;
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message!, Colors.red, Colors.white, 2500);
      return res;
    }
  }

  void signOut() async {
    try {
      _auth.signOut();
      // remove from local storage
      removeFromLocalStorage("username");
      removeFromLocalStorage("email");
      removeFromLocalStorage("photoUrl");
      removeFromLocalStorage("uid");
      removeFromLocalStorage("personalMeetingID");
    } catch (e) {
      print(e);
    }
  }
}
