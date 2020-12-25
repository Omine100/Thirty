import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

import 'package:thirty/standards/interfaceStandards.dart';
import 'package:thirty/standards/methodStandards.dart';

//Method declarations
abstract class BaseCloud {
  //Methods: Account management
  Future<void> signIn(String email, String password);
  Future<void> signUp(BuildContext context,
      GlobalKey<ScaffoldState> scaffoldKey, String email, String password);
  Future<void> signOut();
  Future<FirebaseUser> getCurrentUser();
  Future<bool> getSignedInStatus();
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
  //Class initialization
  InterfaceStandards interfaceStandards = new InterfaceStandards();
  MethodStandards methodStandards = new MethodStandards();

  //Variable initialization
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final db = Firestore.instance;

  //Mechanics: Signs in user
  Future<void> signIn(String email, String password) async {
    AuthResult result = await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
  }

  //Mechanics: Signs up user
  Future<void> signUp(
      BuildContext context,
      GlobalKey<ScaffoldState> scaffoldKey,
      String email,
      String password) async {
    try {
      AuthResult result = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
    } catch (signUpError) {
      if (signUpError is PlatformException) {
        if (signUpError.code == 'ERROR_EMAIL_ALREADY_IN_USE') {
          interfaceStandards.showToast(
              context, scaffoldKey, "Email Already Used.");
        } else if (signUpError.code == 'ERROR_INVALID_EMAIL') {
          interfaceStandards.showToast(
              context, scaffoldKey, "Invalid Email Type..");
        } else if (signUpError.code == 'ERROR_WEAK_PASSWORD') {
          interfaceStandards.showToast(
              context, scaffoldKey, "Password is too Weak.");
        }
      }
    }
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

  //Mechanics: Returns true if someone is signed in
  Future<bool> getSignedInStatus() async {
    var user = await _firebaseAuth.currentUser();
    return user.uid != null ? true : false;
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
    await db.collection(user.uid).document("name").setData({"name": name});
  }

  //Mechanics: Creates goal data
  Future<void> createGoalData(String goal) async {
    String date = methodStandards.getCurrentDate();
    var user = await _firebaseAuth.currentUser();
    //May change document indicator to "favorite" or something like that
    await db
        .collection(user.uid)
        .document("goals")
        .collection("final")
        .document(date)
        .setData({
      "goal": goal,
      "startDate": date,
    });
  }

  //Mechanics: Gets name data
  Future<String> getNameData() async {
    var user = await _firebaseAuth.currentUser();
    DocumentSnapshot snapshot =
        await db.collection(user.uid).document("name").snapshots().first;
    if (!snapshot.exists) {
      return null;
    } else {
      return snapshot.data["name"].toString();
    }
  }

  //Mechanics: Gets goal data stream
  Future<Stream<QuerySnapshot>> getGoalDataStream() async {
    var user = await _firebaseAuth.currentUser();
    Stream<QuerySnapshot> goalDataStream = db
        .collection(user.uid)
        .document("goals")
        .collection("final")
        .snapshots();
    return goalDataStream;
  }

  //Mechanics: Deletes goal data
  Future<void> deleteGoalData(DocumentSnapshot doc) async {
    var user = await _firebaseAuth.currentUser();
    await db
        .collection(user.uid)
        .document("goals")
        .collection("final")
        .document(doc.documentID)
        .delete();
  }

  //Mechanics: Deletes goal data stream
  Future<void> deleteGoalDataStream() async {
    var user = await _firebaseAuth.currentUser();
    await db.collection(user.uid).getDocuments().then((snapshot) {
      for (DocumentSnapshot ds in snapshot.documents) {
        ds.reference.delete();
      }
    });
  }

  //Mechanics: Deletes current user
  Future<void> deleteUser() async {
    var user = await _firebaseAuth.currentUser();
    return user.delete();
  }
}
