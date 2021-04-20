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
  //STRING INPUTS: 'email' and 'password' for user verification
  Future<void> signInEmailAndPassword(String email, String password) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
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

  //MECHANICS: Signs up user with an email and password
  //STRING INPUTS: 'email' and 'password' for user creation
  Future<void> signUpEmailAndPassword(String email, String password) async {
    await auth.createUserWithEmailAndPassword(email: email, password: password);
  }

  //MECHANICS: Signs in user with Google
  //DESCRIPTION: Creates a user with a Google sign in and then returns whether or
  //          not the user is new. We can then handle whether or not we go to the
  //          Intro or Home screen back where we call the method
  //OUTPUT: 'true' if the user is new
  Future<bool> signInGoogle() async {
    final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;
    final GoogleAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);
    final UserCredential result = await auth.signInWithCredential(credential);
    return result.additionalUserInfo.isNewUser;
  }

  //MECHANICS: Signs out user
  //OUTPUT: Calls authentication sign out function
  Future<void> signOut() async {
    return auth.signOut();
  }

  //MECHANICS: Returns current user Id
  Future<String> getCurrentUserId() async {
    var userId = await auth.currentUser.uid;
    return userId;
  }

  //MECHANICS: Returns signed in status
  //DESCRIPTION: If there is someone signed in, then there should always be an
  //          userId to call, so if there is not, no one is signed in
  //OUTPUT: Returns false if the the userId is null, true otherwise
  Future<bool> getSignedInStatus() async {
    var userId = await auth.currentUser.uid;
    return userId != null ? true : false;
  }

  //MECHANICS: Sends an email verification email
  //DESCRIPTION: Uses authentication created function for sending email
  //          verification to the user
  Future<void> sendEmailVerification() async {
    var user = await auth.currentUser;
    user.sendEmailVerification();
  }

  //MECHANICS: Sends a password reset email
  //DESCRIPTION: Uses authentication created function for sending password reset
  //          email to the user
  Future<void> sendPasswordReset(String email) async {
    auth.sendPasswordResetEmail(email: email);
  }

  //MECHANICS: Returns if email is verified
  //DESCRIPTION: Uses authentication created function to check if email is verified
  //OUTPUT: If the email is verified, it returns true, false otherwise
  Future<bool> getEmailVerified() async {
    var user = await auth.currentUser;
    return user.emailVerified;
  }

  //MECHANICS: Creates name data
  //STRING INPUT: 'name' for having a value to save
  //DATA PATH: userId -> name['name']
  Future<void> createNameData(String name) async {
    var userId = await auth.currentUser.uid;
    await firestore.collection(userId).doc("name").set({"name": name});
  }

  //MECHANICS: Creates goal data
  //DESCRIPTION: Create goal but save it under a timeStamp from getCurrentDate()
  //STRING INPUT: 'goal' for having a value to save
  //DATA PATH: userId -> goals -> final -> date['goal', 'date']
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

  //MECHANICS: Returns name data
  //OUTPUT: Reads from firestore and returns string from snapshot or null
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

  //MECHANICS: Returns goal data stream
  //OUTPUT: Reads from firestore and returns snapshots
  Future<Stream<QuerySnapshot>> getGoalDataStream() async {
    var userId = await auth.currentUser.uid;
    Stream<QuerySnapshot> goalDataStream = firestore
        .collection(userId)
        .doc("goals")
        .collection("final")
        .snapshots();
    return goalDataStream;
  }

  //MECHANICS: Deletes one goal
  //DOCUMENT SNAPSHOT INPUT: 'doc' for referencing which document to delete
  //DESCRIPTION: Goes to the specific collection, takes the documentId and use
  //          an authentication created function to delete that specific one
  Future<void> deleteGoalData(DocumentSnapshot doc) async {
    var userId = await auth.currentUser.uid;
    await firestore
        .collection(userId)
        .doc("goals")
        .collection("final")
        .doc(doc.id)
        .delete();
  }

  //MECHANICS: Deletes all user data
  //DESCRIPTION: Goes to the specific user data collection and uses an authentication
  //          created function to delete all of the documents
  Future<void> deleteUserData() async {
    var userId = await auth.currentUser.uid;
    await firestore.collection(userId).get().then((snapshot) {
      for (DocumentSnapshot ds in snapshot.docs) {
        ds.reference.delete();
      }
    });
  }

  //MECHANICS: Deletes the user
  //DESCRIPTION: Uses an authentication created function to delete the user
  Future<void> deleteUser() async {
    auth.currentUser.delete();
    deleteUserData();
  }
}
