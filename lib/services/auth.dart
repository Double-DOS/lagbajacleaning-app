import 'package:firebase_auth/firebase_auth.dart';
import 'package:lagbaja_cleaning/models/user.dart';
import 'package:lagbaja_cleaning/services/database.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // create our own user object
  User _userFromFirebase(FirebaseUser user) {
    return user != null ? User(uid: user.uid) : null;
  }

  // auth change user stream
  Stream<User> get user {
    return _auth.onAuthStateChanged.map(_userFromFirebase);
  }

  //sign in anon
  Future anonSignIn() async {
    try {
      AuthResult result = await _auth.signInAnonymously();
      FirebaseUser user = result.user;
      return _userFromFirebase(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //email and password signup
  Future emailSignUp(Map<String, dynamic> userInfo) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(
          email: userInfo['email'], password: userInfo['password']);
      print(result.user);
      FirebaseUser user = result.user;
      DatabaseService(uid: user.uid).updateUserInfo(
          firstName: userInfo["firstName"],
          lastName: userInfo["lastName"],
          address: userInfo["address"],
          state: userInfo["state"],
          phoneNUmber: userInfo["phoneNumber"]);
      return _userFromFirebase(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // email and password sign in
  Future emailSignIn(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      return _userFromFirebase(user);
    } catch (e) {
      print(e.toString());
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
