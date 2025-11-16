import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:instagram/resources/storage_methodes.dart';
import 'package:instagram/model/user.dart' as model;

class AuthMetodes {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firerstore = FirebaseFirestore.instance;

  Future<model.User> getUserDetails() async {
    User currentuser = auth.currentUser!;
    DocumentSnapshot snap = await firerstore
        .collection('user')
        .doc(currentuser.uid)
        .get();
    return model.User.fromSnapShot(snap);
  }

  Future<String> signUpUsers({
    required String username,
    required String email,
    required String password,
    required String bio,
    required Uint8List file,
  }) async {
    String res = 'some errors has been accured';
    try {
      if (username.isNotEmpty ||
          email.isNotEmpty ||
          password.isNotEmpty ||
          bio.isNotEmpty) {
        UserCredential cred = await auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        print(cred.user!.uid);

        String photoUrl = await StorageMethodes().uploadImageToStorage(
          'profilepics',
          file,
          false,
        );
        model.User user = model.User(
          username: username,
          uid: cred.user!.uid,
          email: email,
          bio: bio,
          followers: [],
          following: [],
          photoUrl: photoUrl,
        );
        await firerstore
            .collection('users')
            .doc(cred.user!.uid)
            .set(user.tojson());
        res = 'success';
      }
    } on FirebaseAuthException catch (err) {
      if (err.code == 'invalid-email') {
        res = 'invalid email';
      } else {
        if (err.code == 'weak-password') {
          res = 'Password should be at least 6 characters';
        }
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  Future<String> loginUsers({
    required String email,
    required String password,
  }) async {
    String res = 'some error occured';
    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        await auth.signInWithEmailAndPassword(email: email, password: password);
        res = 'success';
      } else {
        res = 'please filled the all fields';
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }
}
