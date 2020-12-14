import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:thirty/services/cloudFirestore.dart';
import 'package:thirty/pages/welcome.dart';
import 'package:thirty/pages/home.dart';

//Status declaration
enum AuthStatus {
  NOT_DETERMINED,
  NOT_SIGNED_IN,
  SIGNED_IN,
  REMOVED,
}

class RootScreen extends StatefulWidget {
  RootScreen({this.isLight});

  //Variable reference
  final bool isLight;

  @override
  State<StatefulWidget> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  //Class initialization
  CloudFirestore cloudFirestore = new CloudFirestore();

  //Variable initialization
  final db = Firestore.instance;
  AuthStatus _authStatus = AuthStatus.NOT_DETERMINED;
  String _userId = "";

  //Initial state
  @override
  void initState() {
    super.initState();
    _userId = "";
    cloudFirestore.getCurrentUser().then((user) {
      setState(() {
        _authStatus =
            user?.uid == null ? AuthStatus.NOT_SIGNED_IN : AuthStatus.SIGNED_IN;
        if (_authStatus == AuthStatus.SIGNED_IN) {
          signInCallback();
        }
      });
    });
  }

  //Mechanics: Sets status to logged in with current user
  void signInCallback() {
    cloudFirestore.getCurrentUser().then((user) {
      setState(() {
        _userId = user.uid;
        _authStatus = AuthStatus.SIGNED_IN;
      });
    });
  }

  //Mechanics: Sets status to logged out
  void signOutCallback() {
    setState(() {
      _authStatus = AuthStatus.NOT_SIGNED_IN;
      _userId = "";
    });
  }

  //User interface: Builds circular progress indicator with animation
  Widget buildWaitingScrreen() {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: CircularProgressIndicator(),
      ),
    );
  }

  //User interface: Root screen
  @override
  Widget build(BuildContext context) {
    switch (_authStatus) {
      case AuthStatus.NOT_DETERMINED:
        return buildWaitingScrreen();
        break;
      case AuthStatus.NOT_SIGNED_IN:
        return new WelcomeScreen();
      case AuthStatus.SIGNED_IN:
        if (_userId != null) {
          return new HomeScreen(
            userId: _userId,
          );
        } else {
          return buildWaitingScrreen();
        }
        break;
      default:
        return buildWaitingScrreen();
    }
  }
}
