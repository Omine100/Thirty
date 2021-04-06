import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'dart:async';

import 'package:thirty/standards/methodStandards.dart';

//METHOD DECLARATIONS
abstract class BaseCloud {
  //METHODS: Account management
  Future<void> signInEmailAndPassword(String email, String password);
  Future<void> signUpEmailAndPassword(String email, String password);
  Future<void> signInGoogle();
  Future<void> signOut();
  Future<String> getCurrentUserId();
  Future<bool> getSignedInStatus();
  Future<void> sendEmailVerification();
  Future<void> sendPasswordReset(String email);
  Future<bool> getEmailVerified();

  //METHODS: Data management
  Future<void> createNameData(String name);
  Future<void> createGoalData(String goal);
  Future<String> getNameData();
  Future<Stream<QuerySnapshot>> getGoalDataStream();
  Future<void> deleteGoalData(DocumentSnapshot doc);
  Future<void> deleteUserData();
  Future<void> deleteUser();
}

class CloudFirestore implements BaseCloud {
  //CLASS INITIALIZATION
  MethodStandards methodStandards = new MethodStandards();

  //VARIABLE INITIALIZATION
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  //MECHANICS: Signs in user with an email and password
  Future<void> signInEmailAndPassword(String email, String password) async {
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print(
            'No user found for that email.'); //Maybe make a call to a widget for a toast view
      } else if (e.code == 'wrong-password') {
        print(
            'Wrong password provided for that user.'); //Maybe make a call to a widget for a toast view
      }
    }
  }

  //Mechanics: Signs up user with an email and password
  Future<void> signUpEmailAndPassword(String email, String password) async {
    UserCredential result = await auth.createUserWithEmailAndPassword(
        email: email, password: password);
  }

  //Mechanics: Signs in user with Google
  Future<void> signInGoogle() async {
    final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;
    final GoogleAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);
  }

  //Mechanics: Signs out user
  Future<void> signOut() async {
    return auth.signOut();
  }

  //Mechanics: Returns current user Id
  Future<String> getCurrentUserId() async {
    var userId = await auth.currentUser.uid;
    return userId;
  }

  //Mechanics: Returns signed in status
  Future<bool> getSignedInStatus() async {
    var userId = await auth.currentUser.uid;
    return userId != null ? true : false;
  }

  //Mechanics: Sends an email verification email
  Future<void> sendEmailVerification() async {
    var user = await auth.currentUser;
    user.sendEmailVerification();
  }

  //Mecahnics: Sends a password reset email
  Future<void> sendPasswordReset(String email) async {
    auth.sendPasswordResetEmail(email: email);
  }

  //Mechanics: Returns if email is verified
  Future<bool> getEmailVerified() async {
    var user = await auth.currentUser;
    return user.emailVerified;
  }

  //Mechanics: Creates name data
  Future<void> createNameData(String name) async {
    var userId = await auth.currentUser.uid;
    await firestore.collection(userId).doc("name").set({"name": name});
  }

  //Mechanics: Creates goal data
  Future<void> createGoalData(String goal) async {
    String date = methodStandards.getCurrentDate();
    var userId = await auth.currentUser.uid;
    //May change document indicator to "favorite" or something like that
    await firestore
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
    var userId = await auth.currentUser.uid;
    QueryDocumentSnapshot snapshot =
        await firestore.collection(userId).doc("name").snapshots().first;
    if (!snapshot.exists) {
      return null;
    } else {
      return snapshot.get("name").toString();
    }
  }

  //Mechanics: Returns goal data stream
  Future<Stream<QuerySnapshot>> getGoalDataStream() async {
    var userId = await auth.currentUser.uid;
    Stream<QuerySnapshot> goalDataStream = firestore
        .collection(userId)
        .doc("goals")
        .collection("final")
        .snapshots();
    return goalDataStream;
  }

  //Mechanics: Deletes one goal
  Future<void> deleteGoalData(DocumentSnapshot doc) async {
    var userId = await auth.currentUser.uid;
    await firestore
        .collection(userId)
        .doc("goals")
        .collection("final")
        .doc(doc.id)
        .delete();
  }

  //Mechanics: Deletes all user data
  Future<void> deleteUserData() async {
    var userId = await auth.currentUser.uid;
    await firestore.collection(userId).get().then((snapshot) {
      for (DocumentSnapshot ds in snapshot.docs) {
        ds.reference.delete();
      }
    });
  }

  //Mechanics: Deletes the user
  Future<void> deleteUser() async {
    auth.currentUser.delete();
    deleteUserData();
  }
}
