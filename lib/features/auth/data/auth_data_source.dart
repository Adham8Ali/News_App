import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:news_app/core/models/user_model.dart';

class AuthDataSource {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> signUp(String email, String password, String name) async {
    UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    UserModel userModel = UserModel(
      id: userCredential.user!.uid,
      email: email,
      name: name,
      favorite: [],
    );

    await _firestore
        .collection('users')
        .doc(userCredential.user!.uid)
        .set(userModel.toJson());
  }

  Future<UserModel> login(String email, String password) async {
    UserCredential userCredential = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    final data =
        await _firestore
            .collection('users')
            .doc(userCredential.user!.uid)
            .get();

    return UserModel.fromJson(data.data()!);
  }

  Future<void> logout() async {
    await _auth.signOut();
  }
}
