import 'package:firebase_auth/firebase_auth.dart';
import 'package:step/models/usermodels.dart';

class AuthService {
  static FirebaseAuth _auth = FirebaseAuth.instance;

  // create user object based on User(FirebaseUser)
  StepUser _userFromFirebaseUser(User user) {
    return user != null ? StepUser(uid: user.uid) : null;
  }

  //Auth change user stream
  Stream<StepUser> get user {
    return _auth.authStateChanges().map(_userFromFirebaseUser);
  }

  //sign in with e-mail and password
  Future signInWithEmailPassword({String email, String password}) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User user = result.user;
      _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //sign in with email and password
  Future registerWithEmailPassword({String email, String password}) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User user = result.user;
      _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //Logout with E-mail and password
  static signout() {
    return _auth.signOut();
  }
  //reister with e-mail and password

}
