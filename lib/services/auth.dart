import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:step/models/usermodels.dart';
import 'package:step/services/database.dart';

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
  // i want to set the school name to school name and role to teacher while redistering a school
  // Future registerWithEmailPassword({String email, String password}) async {
  //   try {
  //     UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
  //     User user = result.user;
  //     return _userFromFirebaseUser(user);
  //   } catch (e) {
  //     print(e.toString());
  //     return null;
  //   }
  // }
//  ------------------------------------------------
//  ---------Register School------------------------
//  ------------------------------------------------
  Future registerSchoolWithEmailPassword({
    String email,
    String password,
    String name,
    String role,
    String city,
    String state,
    String country,
    String collectionWhereUserShouldBe,
    String collectionWhereRoleShouldBe,
  }) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    // final User user = auth.currentUser;
    print("userid before " + auth.currentUser.uid.toString());
    FirebaseApp tempApp = await Firebase.initializeApp(name: 'com.step.bitnosh.co.in', options: Firebase.app().options);

    try {
      UserCredential result = await FirebaseAuth.instanceFor(app: tempApp).createUserWithEmailAndPassword(email: email, password: password);
      // User user = result.user;
      print("userid after " + auth.currentUser.uid.toString());
      // add users
      await UserHelper(uid: result.user.uid).addSchoolDataToFirebase(name, email, role, city, state, country, collectionWhereUserShouldBe);
      // add role to firebase
      await UserHelper(uid: result.user.uid).addRoleDataToFirebase(collectionWhereRoleShouldBe, role);
      tempApp.delete();
      return 'okey';
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // -----------------------------------------------
  // ------Register users --------------------------
  // -----------------------------------------------
  Future registerWithEmailPasswordUser({
    String email,
    String password,
    String name,
    String role,
    String city,
    String state,
    String country,
    String standard,
    String division,
    String subject,
    String collectionWhereUserShouldBe,
    String collectionWhereRoleShouldBe,
    String school,
  }) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    final User user = auth.currentUser;
    print("userid before " + auth.currentUser.uid.toString());
    FirebaseApp app = await Firebase.initializeApp(name: 'com.bitnosh.in', options: Firebase.app().options);

    try {
      UserCredential result = await FirebaseAuth.instanceFor(app: app).createUserWithEmailAndPassword(email: email, password: password);
      // User user = result.user;
      print("userid after " + auth.currentUser.uid.toString());
      // add users
      await UserHelper(uid: result.user.uid)
          .addDataToFirebase(name, email, role, city, state, country, standard, division, subject, collectionWhereUserShouldBe, school);
      // add role to firebase
      await UserHelper(uid: result.user.uid).addRoleDataToFirebase(collectionWhereRoleShouldBe, role);
      return 'okey';
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

// ---------------------------------------------------------------------------------------
//----------------------Have prob with the starred code below --------------------------
// -----------------------------------------------------------------------------------------

  // Future registerWithEmailPassword(
  //   String email,
  //   String password,
  //   String name,
  //   String role,
  //   String city,
  //   String state,
  //   String country,
  //   // String standard,
  //   // String division,
  //   // String subject,
  // ) async {
  //   try {
  //     FirebaseApp stepApp = await Firebase.initializeApp(name: 'step-5587a', options: Firebase.app().options);

  //     UserCredential result = await FirebaseAuth.instanceFor(app: stepApp).createUserWithEmailAndPassword(email: email, password: password);
  //     await UserHelper(uid: result.user.uid).addSchoolData(name, email, role, city, state, country);

  //     stepApp.delete();
  //     return 'Registration successful with out logging in';
  //   } catch (e) {
  //     print(e.toString());
  //     return null;
  //   }
  // }

  //Logout with E-mail and password
  static signout() {
    return _auth.signOut();
  }
}
