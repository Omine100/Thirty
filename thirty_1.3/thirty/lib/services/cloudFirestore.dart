import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';

import 'package:thirty/standards/methodStandards.dart';

//Method declarations
abstract class BaseCloud {
  //Methods: Account management
  Future<void> signIn(String email, String password);
  Future<void> signUp(String email, String password);
  Future<void> signOut();
  Future<String> getCurrentUserId();
  Future<bool> getSignedInStatus();
  Future<void> sendEmailVerification();
  Future<void> sendPasswordReset(String email);
  Future<bool> getEmailVerified();

  //Methods: Data management
  Future<void> createNameData(String name);
  Future<void> createGoalData(String goal);
  Future<String> getNameData();
  Future<Stream<QuerySnapshot>> getGoalDataStream();
  Future<void> deleteGoalData(DocumentSnapshot doc);
  Future<void> deleteUserData();
  Future<void> deleteUser();
}

class CloudFirestore implements BaseCloud {
  //Class initialization
  MethodStandards methodStandards = new MethodStandards();

  //Variable initialization
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final db = FirebaseFirestore.instance; //Maybe have it as Firestore

  //Mechanics: Signs in user
  Future<void> signIn(String email, String password) async {
    UserCredential result = await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
  }

  //Mechanics: Signs up user
  Future<void> signUp(String email, String password) async {
    UserCredential result = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
  }

  //Mechanics: Signs out user
  Future<void> signOut() async {
    return _firebaseAuth.signOut();
  }

  //Mechanics: Returns current user Id
  Future<String> getCurrentUserId() async {
    var userId = await _firebaseAuth.currentUser.uid;
    return userId;
  }

  //Mechanics: Returns signed in status
  Future<bool> getSignedInStatus() async {
    var userId = await _firebaseAuth.currentUser.uid;
    return userId != null ? true : false;
  }

  //Mechanics: Sends an email verification email
  Future<void> sendEmailVerification() async {
    var user = await _firebaseAuth.currentUser;
    user.sendEmailVerification();
  }

  //Mecahnics: Sends a password reset email
  Future<void> sendPasswordReset(String email) async {
    _firebaseAuth.sendPasswordResetEmail(email: email);
  }

  //Mechanics: Returns if email is verified
  Future<bool> getEmailVerified() async {
    var user = await _firebaseAuth.currentUser;
    return user.emailVerified;
  }

  //Mechanics: Creates name data
  Future<void> createNameData(String name) async {
    var userId = await _firebaseAuth.currentUser.uid;
    await db.collection(userId).doc("name").set({"name": name});
  }

  //Mechanics: Creates goal data
  Future<void> createGoalData(String goal) async {
    String date = methodStandards.getCurrentDate();
    var userId = await _firebaseAuth.currentUser.uid;
    //May change document indicator to "favorite" or something like that
    await db
        .collection(userId)
        .doc("goals")
        .collection("final")
        .doc(date)
        .set({
      "goal": goal,
      "startDate": date,
    });
  }

  //Mechanics: Returns name data
  Future<String> getNameData() async {
    var userId = await _firebaseAuth.currentUser.uid;
    QueryDocumentSnapshot snapshot =
        await db.collection(userId).doc("name").snapshots().first;
    if (!snapshot.exists) {
      return null;
    } else {
      return snapshot.get("name").toString();
    }
  }

  //Mechanics: Returns goal data stream
  Future<Stream<QuerySnapshot>> getGoalDataStream() async {
    var userId = await _firebaseAuth.currentUser.uid;
    Stream<QuerySnapshot> goalDataStream = db
        .collection(userId)
        .doc("goals")
        .collection("final")
        .snapshots();
    return goalDataStream;
  }

  //Mechanics: Deletes one goal
  Future<void> deleteGoalData(DocumentSnapshot doc) async {
    var userId = await _firebaseAuth.currentUser.uid;
    await db
        .collection(userId)
        .doc("goals")
        .collection("final")
        .doc(doc.id)
        .delete();
  }

  //Mechanics: Deletes all user data
  Future<void> deleteUserData() async {
    var userId = await _firebaseAuth.currentUser.uid;
    await db.collection(userId).get().then((snapshot) {
      for (DocumentSnapshot ds in snapshot.docs) {
        ds.reference.delete();
      }
    });
  }

  //Mechanics: Deletes the user
  Future<void> deleteUser() async {
    _firebaseAuth.currentUser.delete();
    deleteUserData();
  }
}
