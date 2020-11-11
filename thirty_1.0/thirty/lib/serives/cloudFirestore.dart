import 'package:flutter/material.dart';

//Method declarations
abstract class BaseCloud {
  //Methods: Account management
  Future<void> signIn(String email, String password);
  Future<void> signUp(String email, String password);
  Future<void> signOut();
  Future<FirebaseUser> getCurrentUser();
  Future<void> sendEmailVerification();
  Future<void> sendPasswordReset(String email);
  Future<bool> isEmailVerified();

  //Methods: Data management
  Future<void> createNameData(String name);
  Future<void> createGoalData(String goal);
  Future<void> getNameData();
  Future<void> getGoalDataStream();
  Future<void> deleteGoalData();
  Future<void> deleteGoalDataStream();
  Future<void> deleteCurrentUser();
}

class CloudFirestore implements BaseCloud {
  //Variable initialization
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final db = Firestore.instance;

  //Mechanics: Signs in user
  Future<void> signIn(String email, String password) async {
    AuthResult result = await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
  }

  //Mechanics: Signs up user
  Future<void> signUp(String email, String password) async {
    AuthResult result = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
  }

  //Mechanics: Signs out user
  Future<void> signOut() async {
    return _firebaseAuth.signOut();
  }

  //Mechanics: Returns user
  Future<FirebaseUser> getCurrentUser() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    return user;
  }

  //Mechanics: Sends user an email for verification
  Future<void> sendEmailVerification() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    user.sendEmailVerification();
  }

  //Mechanics: Sends user an email for password resetting
  Future<void> sendPasswordReset(String email) async {
    _firebaseAuth.sendPasswordResetEmail(email: email);
  }

  //Mechanics: Returns true if email is verified
  Future<bool> isEmailVerified() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    return user.isEmailVerified;
  }
}

CloudFirestore db = CloudFirestore();
