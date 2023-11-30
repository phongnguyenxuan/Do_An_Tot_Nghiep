import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:do_an_tot_nghiep/configs/constants.dart';
import 'package:do_an_tot_nghiep/configs/style_config.dart';
import 'package:do_an_tot_nghiep/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthServices {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FacebookAuth _facebookAuth = FacebookAuth.instance;
  // get user details
  Future<UserModel> getUserDetails() async {
    User currentUser = _auth.currentUser!;

    DocumentSnapshot documentSnapshot =
        await _firestore.collection('users').doc(currentUser.uid).get();

    return UserModel.fromMap(documentSnapshot.data() as Map<String, dynamic>);
  }

  // GOOGLE SIGN IN
  Future<void> logInWithGoogle(BuildContext context) async {
    try {
      EasyLoading.show();
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;
      EasyLoading.dismiss();
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      if (context.mounted) firebaseSignInWithCredential(credential, context);
    } on PlatformException catch (_) {
      EasyLoading.dismiss();
    }
  }

  //Facebook login
  Future<void> logInWithFacebook(BuildContext context) async {
    EasyLoading.show();
    final LoginResult result =
        await _facebookAuth.login(permissions: ['email', 'public_profile']);
    if (result.status == LoginStatus.success) {
      final credential =
          FacebookAuthProvider.credential(result.accessToken!.token);
      if (context.mounted) firebaseSignInWithCredential(credential, context);
    }
    EasyLoading.dismiss();
  }

  // ANONYMOUSLY SIGNIN
  Future<void> anonymouslySigin() async {
    try {
      EasyLoading.show();
      await FirebaseAuth.instance.signInAnonymously();
      EasyLoading.dismiss();
    } on FirebaseAuthException catch (_) {
      EasyLoading.dismiss();
    }
  }

  //Link account
  Future<void> linkAccount(bool isGoogle, BuildContext context) async {
    if (isGoogle) {
      logInWithGoogle(context);
    } else {
      logInWithFacebook(context);
    }
  }

  Future<void> firebaseSignInWithCredential(
      OAuthCredential credential, BuildContext context) async {
    try {
      UserCredential? credential0 =
          await _auth.signInWithCredential(credential);
      UserModel userModel = UserModel(
          uid: credential0.user?.uid,
          userName: credential0.user?.displayName,
          email: credential0.user?.email,
          score: 0,
          photoURL: credential0.user?.photoURL);
      _firestore
          .collection('users')
          .doc(credential0.user?.uid)
          .get()
          .then((value) async {
        if (!value.exists) {
          await _firestore
              .collection("users")
              .doc(credential0.user?.uid)
              .set(userModel.toMap());
        }
      });
    } on FirebaseAuthException catch (e) {
      Future(() {
        SnackBar snackBar = SnackBar(
          backgroundColor: kColorPrimary,
          elevation: 0,
          content: Text(
            e.message!,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontFamily: kfontFamily, color: Colors.white, fontSize: 14.sp),
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      });
    }
  }

  // SIGN OUT
  Future<void> signOut() async {
    try {
      EasyLoading.show();
      await _googleSignIn.signOut();
      await _facebookAuth.logOut();
      await _auth.signOut();
      EasyLoading.dismiss();
    } on FirebaseAuthException catch (_) {
      EasyLoading.dismiss();
      //showSnackBar(context, e.message!); // Displaying the error message
    }
  }
}
