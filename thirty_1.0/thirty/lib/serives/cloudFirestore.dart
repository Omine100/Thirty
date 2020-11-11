import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
  Future<String> getNameData();
  Future<Stream<QuerySnapshot>> getGoalDataStream();
  Future<void> deleteGoalData(DocumentSnapshot doc);
  Future<void> deleteGoalDataStream();
  Future<void> deleteUser();
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
    var user = await _firebaseAuth.currentUser();
    return user;
  }

  //Mechanics: Sends user an email for verification
  Future<void> sendEmailVerification() async {
    var user = await _firebaseAuth.currentUser();
    user.sendEmailVerification();
  }

  //Mechanics: Sends user an email for password resetting
  Future<void> sendPasswordReset(String email) async {
    _firebaseAuth.sendPasswordResetEmail(email: email);
  }

  //Mechanics: Returns true if email is verified
  Future<bool> isEmailVerified() async {
    var user = await _firebaseAuth.currentUser();
    return user.isEmailVerified;
  }

  //Mechanics: Creates name data
  Future<void> createNameData(String name) async {
    var user = await _firebaseAuth.currentUser();
    //Need to figure out how I want to organize the data
  }

  //Mechanics: Creates goal data
  Future<void> createGoalData(String goal) async {
    var user = await _firebaseAuth.currentUser();
    //Need to figure out how I want to organize the data
  }

  //Mechanics: Gets name data
  Future<String> getNameData() async {
    var user = await _firebaseAuth.currentUser();
    //Need to figure out how I want to organize the data
  }

  //Mechanics: Gets goal data stream
  Future<Stream<QuerySnapshot>> getGoalDataStream() async {
    var user = await _firebaseAuth.currentUser();
    //Need to figure out how I want to organize the data
  }

  //Mechanics: Deletes goal data
  Future<void> deleteGoalData(DocumentSnapshot doc) async {
    var user = await _firebaseAuth.currentUser();
    //Need to figure out how I want to organize the data
  }

  //Mechanics: Deletes goal data stream
  Future<void> deleteGoalDataStream() async {
    var user = await _firebaseAuth.currentUser();
    //Need to figure out how I want to organize the data
  }

  //Mechanics: Deletes current user
  Future<void> deleteUser() async {
    var user = await _firebaseAuth.currentUser();
    return user.delete();
  }
}

CloudFirestore db = CloudFirestore();
