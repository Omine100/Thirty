import 'package:flutter/material.dart';

//Method declarations
abstract class BaseCloud {
  //Methods: Account management
  Future<void> signIn(String email, String password);
  Future<void> signUp(BuildContext context,
      GlobalKey<ScaffoldState> scaffoldKey, String email, String password);
  Future<void> signOut();
  Future<FirebaseUser> getCurrentUser();
  Future<String> getCurrentUserId();
  Future<bool> isSignedInStatus();
  Future<void> sendEmailVerification();
  Future<void> sendPasswordReset(String email);
  Future<bool> isEmailVerified();

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

  //Variable initialization

  //Mechanics: Signs in user

  //Mechanics: Signs up user

  //Mechanics: Signs out user

  //Mechanics: Returns current user

  //Mechanics: Returns current user Id

  //Mechanics: Returns signed in status

  //Mechanics: Sends an email verification email

  //Mecahnics: Sends a password reset email

  //Mechanics: Returns if email is verified

  //Mechanics: Creates name data

  //Mechanics: Creates goal data

  //Mechanics: Returns name data

  //Mechanics: Returns goal data stream

  //Mechanics: Deletes one goal

  //Mechanics: Deletes all user data

  //Mechanics: Deletes the user
}
