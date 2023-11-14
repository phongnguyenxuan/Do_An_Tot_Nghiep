import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/user_model.dart';

class FireStoreServices {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> updateScoreToServer({required int score}) async {
    final User? user = FirebaseAuth.instance.currentUser;
    UserModel userModel = UserModel(
        uid: user?.uid,
        userName: user?.displayName,
        email: user?.email,
        score: score,
        photoURL: user?.photoURL);
    await _firestore.collection("users").doc(user?.uid).set(userModel.toMap());
  }
}
