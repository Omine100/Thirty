import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_twitter_login/flutter_twitter_login.dart';
import 'dart:async';
import 'dart:io';

import 'package:thirty/standards/methodStandards.dart';
import 'package:thirty/standards/interfaceStandards.dart';

//METHOD DECLARATIONS
abstract class BaseCloud {
  //METHODS: Account management
  Future<void> signInEmailAndPassword(
      BuildContext context, String email, String password);
  Future<void> signUpEmailAndPassword(
      BuildContext context, String email, String password, String name);
  Future<void> signInGoogle();
  Future<void> signInTwitter();
  Future<void> signOut();
  Future<bool> getSignedInStatus();
  Future<String> getCurrentUserId();
  Future<void> sendEmailVerification();
  Future<void> sendPasswordReset(String email);
  Future<bool> getEmailVerified();

  //METHODS: Data management
  Future<void> createNameData(String name);
  Future<void> createImageData(String fileName, File image);
  Future<void> createImageURLData(String date, String imageURL);
  Future<String> getNameData();
  Image getImageData(String imageURL);
  Future<List<String>> getImageURLStreamData();
  Future<void> deleteImageData(DocumentSnapshot doc, String imageURL);
  Future<void> deleteUserData();
  Future<void> deleteUser();
}

class CloudFirestore implements BaseCloud {
  //CLASS INITIALIZATION
  MethodStandards methodStandards = new MethodStandards();

  //VARIABLE INITIALIZATION
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseStorage storage = FirebaseStorage.instance;

  //MECHANICS: Signs in user with an email and password
  //DESCRIPTION: Signs in and then calls interfaceStandards to display a toast
  //          message if there is an error
  //STRING INPUTS: 'email' and 'password' for user verification
  Future<void> signInEmailAndPassword(
      BuildContext context, String email, String password) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      String key;
      switch (e.code) {
        case "invalid-email":
          key = "errorInvalidEmail";
          break;
        case "wrong-password":
          key = "errorWrongPassword";
          break;
        case "user-not-found":
          key = "errorUserNotFound";
          break;
        case "user-disabled":
          key = "errorUserDisabled";
          break;
        default:
          key = "errorDefault";
      }
      InterfaceStandards().showToastMessage(context, key);
    }
  }

  //MECHANICS: Signs up user with an email and password
  //DESCRIPTION: Signs in and then calls interfaceStandards to display a toast
  //          message if there is an error. We also create the name data here and send the
  //          email verification off
  //STRING INPUTS: 'email' and 'password' for user creation, 'name' used for data creation
  Future<void> signUpEmailAndPassword(
      BuildContext context, String email, String password, String name) async {
    try {
      await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      await createNameData(name);
      sendEmailVerification();
    } on FirebaseAuthException catch (e) {
      String key;
      switch (e.code) {
        case "invalid-password":
          key = "errorInvalidPassword";
          break;
        case "invalid-email":
          key = "errorInvalidEmail";
          break;
        case "email-already-exists":
          key = "errorEmailAlreadyExists";
          break;
        case "invalid-credential":
          key = "errorInvalidEmail";
          break;
        default:
          key = "errorDefault";
      }
      InterfaceStandards().showToastMessage(context, key);
    }
  }

  //MECHANICS: Signs in user with Google
  //DESCRIPTION: Creates a user with a Google sign in and then returns whether or
  //          not the user is new. We can then handle whether or not we go to the
  //          Intro or Home screen back where we call the method. We also create
  //          name data if it is a new user
  //OUTPUT: 'true' if the user is new
  Future<bool> signInGoogle() async {
    final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication result = await googleUser.authentication;
    final GoogleAuthCredential googleCredential = GoogleAuthProvider.credential(
        accessToken: result.accessToken, idToken: result.idToken);
    final UserCredential userCredential =
        await auth.signInWithCredential(googleCredential);
    if (userCredential.additionalUserInfo.isNewUser) {
      await createNameData(googleUser.displayName);
    }
    return userCredential.additionalUserInfo.isNewUser;
  }

  //MECHANICS: Signs in user with Twitter
  //DESCRIPTION: Takes the user consumerKey and consumerSecret from a developer
  //          account and allows for the user to sign in and returns whether or
  //          not the user is new. We can then handle whether or not we go to the
  //          Intro or Home screen back where we call the method
  //BEARER TOKEN: AAAAAAAAAAAAAAAAAAAAAAktOwEAAAAAnUDLMWtzIyxZLpHanZZokQruzOc%3
  //           DKBrBIFVdiw9OvaN5vcAAU4v8jCgO6dOluSp5K7smTXM9RBgMWj
  //OUTPUT: 'true' if the user is new
  Future<bool> signInTwitter() async {
    final TwitterLogin twitterLogin = new TwitterLogin(
      consumerKey: '06tLwhwnkvJeK5smvt9gPOTe5',
      consumerSecret: 'ob0s5XtYYJTEUX4GptaruP1n5Zvvq2hGyyHDeYkPylDD4RdOAC',
    );
    final TwitterLoginResult result = await twitterLogin.authorize();
    if (result.status == TwitterLoginStatus.loggedIn) {
      final AuthCredential twitterCredential = TwitterAuthProvider.credential(
          accessToken: result.session.token, secret: result.session.secret);
      final UserCredential userCredential =
          await auth.signInWithCredential(twitterCredential);
      if (userCredential.additionalUserInfo.isNewUser) {
        await createNameData(result.session.username);
      }
      return userCredential.additionalUserInfo.isNewUser;
    } else if (result.status == TwitterLoginStatus.cancelledByUser) {
      return null;
    } else {
      return null;
    }
  }

  //MECHANICS: Signs out user
  //OUTPUT: Calls authentication sign out function
  Future<void> signOut() async {
    return auth.signOut();
  }

  //MECHANICS: Returns signed in status
  //DESCRIPTION: If there is someone signed in, then there should always be an
  //          userId to call, so if there is not, no one is signed in
  //OUTPUT: Returns false if the the userId is null, true otherwise
  Future<bool> getSignedInStatus() async {
    if (auth.currentUser?.uid == null) {
      return false;
    }
    return true;
  }

  //MECHANICS: Returns current user Id
  Future<String> getCurrentUserId() async {
    var userId = auth.currentUser.uid;
    return userId;
  }

  //MECHANICS: Sends an email verification email
  //DESCRIPTION: Uses authentication created function for sending email
  //          verification to the user
  Future<void> sendEmailVerification() async {
    var user = auth.currentUser;
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
    var user = auth.currentUser;
    return user.emailVerified;
  }

  //MECHANICS: Creates name data
  //STRING INPUT: 'name' for having a value to save
  //DATA PATH: userId -> name['name']
  Future<void> createNameData(String name) async {
    var userId = auth.currentUser.uid;
    await firestore.collection(userId).doc("name").set({"name": name});
  }

  //MECHANICS: Creates image data
  //DESCRIPTION: Create image but save it under a timeStamp from getCurrentDate().
  //          We actually create data in two places, to store the image and then
  //          the imageURL and the date data
  //STRING INPUT: 'fileName' for having a value to reference
  //FILE INPUT: 'imageFile' for having a value to save
  //FIREBASE DATA PATH: imageURL
  //FIRESTORE DATA PATH: userId -> images -> complete -> date[imageURL]
  Future<void> createImageData(String fileName, File imageFile) async {
    String date = methodStandards.getCurrentDate();
    try {
      await storage.ref(fileName).putFile(
        imageFile,
        SettableMetadata(customMetadata: {
          'date': date
        })
      );
      storage.ref(fileName).getDownloadURL().then((_imageURL) => {
        createImageURLData(date, _imageURL)
      });
    } on FirebaseException catch (e) {
      print(e);
    }
  }

  //MECHANICS: Creates imageURL data
  //DESCRIPTION: Puts the imageURL in the firestore databases, this allows for us
  //          to access specific imageURLs later on down the line, instead of
  //          loading every single one
  //STRING INPUT: 'date' & 'imageURL' for having values to save
  //FIRESTORE DATA PATH: userId -> images -> complete -> date[imageURL]
  Future<void> createImageURLData(String date, String imageURL) async {
    var userId = auth.currentUser.uid;
    await firestore.collection(userId).doc("images").collection("complete").
      doc(date).set({"imageURL": imageURL});
  }

  //MECHANICS: Returns name data
  //OUTPUT: Reads from firestore and returns string from snapshot or null
  Future<String> getNameData() async {
    var userId = auth.currentUser.uid;
    DocumentSnapshot snapshot =
        await firestore.collection(userId).doc("name").snapshots().first;
    if (!snapshot.exists) {
      return null;
    } else {
      return snapshot.get("name").toString();
    }
  }

  //MECHANICS: Returns image data
  //OUTPUT: Reads from firebase and returns image widget
  Image getImageData(String imageURL) {
    return Image.network(imageURL, fit: BoxFit.fitWidth,);
  }

  //MECHANICS: Returns imageURL stream data
  //DESCRIPTION: Looks at the cloudFirestore data for a specific user and
  //          then gets all of the imageURLs for that person
  //OUTPUT: List of strings that are imageURLs
  Future<List<String>> getImageURLStreamData() async {
    var userId = auth.currentUser.uid;
    final QuerySnapshot querySnapshot = await firestore.collection(userId).doc("images").
      collection("complete").get();
    final List<DocumentSnapshot> documentSnapshots = querySnapshot.docs;
    List<String> imageURLStream = List<String>();
    documentSnapshots.forEach((snapshot) {
      imageURLStream.add(snapshot.get("imageURL"));
    });
    return imageURLStream;
  }

  //MECHANICS: Deletes one image
  //DOCUMENTSNAPSHOT INPUT: 'doc' For deleting from firestore
  //STRING INPUT: 'imageURL' for referencing which image to delete
  //DESCRIPTION: Goes to the specific image, takes the URL and uses an
  //          authentication created function to delete that specific one
  Future<void> deleteImageData(DocumentSnapshot doc, String imageURL) async {
    //MECHANICS: Firebase deletion
    Reference reference = FirebaseStorage.instance.refFromURL(imageURL);
    reference.delete();

    //MECHANICS: Firestore deletion
    var userID = auth.currentUser.uid;
    await firestore
        .collection(userID)
        .doc("images")
        .collection("complete")
        .doc(doc.id)
        .delete();
  }

  //MECHANICS: Deletes all user data
  //DESCRIPTION: Goes to the specific user data collection and uses an authentication
  //          created function to delete all of the documents
  Future<void> deleteUserData() async {
    var userId = auth.currentUser.uid;
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
