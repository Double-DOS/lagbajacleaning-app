import 'package:firebase_auth/firebase_auth.dart';
import 'package:lagbaja_cleaning/models/sessions.dart';
import 'package:lagbaja_cleaning/models/user.dart';
import 'package:lagbaja_cleaning/services/database.dart';
import 'dart:io';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // create our own user object
  MyUser _userFromFirebase(User user) {
    return user != null ? MyUser(uid: user.uid, email: user.email) : null;
  }

  // auth change user stream
  Stream<MyUser> get user {
    return _auth.authStateChanges().map(_userFromFirebase);
  }

  //email and password signup
  Future emailSignUp(Map<String, dynamic> userInfo) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: userInfo['email'], password: userInfo['password']);
      print(result.user);
      User user = result.user;
      DatabaseService(uid: user.uid).updateUserInfo(
          firstName: userInfo["firstName"],
          lastName: userInfo["lastName"],
          address: userInfo["address"],
          state: userInfo["state"],
          city: userInfo["city"],
          phoneNumber: userInfo["phoneNumber"]);
      return _userFromFirebase(user);
    } on FirebaseAuthException catch (e) {
      print("Failed on the error ==>${e.code}");
      print(e.message);
      return e.message;
    }
  }

  // email and password sign in
  Future emailSignIn(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;
      print(user);
      return "pass";
    } on FirebaseAuthException catch (e) {
      print(e.message);
      print(e.code);
      if (e.code == 'wrong-password') return "Incorrect Password!";
      if (e.code == 'user-not-found') return "No user with that email!";
      if (e.code == 'account-exists-with-different-credential')
        return "Account with that email already exists!";
      return null;
    }
  }

  //sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
