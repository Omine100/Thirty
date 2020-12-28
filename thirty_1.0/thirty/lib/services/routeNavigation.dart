import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:thirty/services/cloudFirestore.dart';
import 'package:thirty/standards/animationStandards.dart';
import 'package:thirty/standards/interfaceStandards.dart';
import 'package:thirty/pages/welcome.dart';
import 'package:thirty/pages/login.dart';
import 'package:thirty/pages/forgotPassword.dart';
import 'package:thirty/pages/intro.dart';
import 'package:thirty/pages/home.dart';

class RouteNavigation extends StatefulWidget {
  RouteNavigation({this.isLight});

  //Variable reference
  final bool isLight;

  @override
  State<StatefulWidget> createState() => _RouteNavigationState();
}

class _RouteNavigationState extends State<RouteNavigation> {
  //Class initialization
  CloudFirestore cloudFirestore = new CloudFirestore();
  Routes routes = new Routes();
  InterfaceStandards interfaceStandards = new InterfaceStandards();
  WelcomeScreen welcomeScreen = new WelcomeScreen();
  LoginScreen loginScreen = new LoginScreen();
  ForgotPasswordScreen forgotPasswordScreen = new ForgotPasswordScreen();
  IntroScreen introScreen = new IntroScreen();
  HomeScreen homeScreen = new HomeScreen();

  //Variable initialization
  bool _isSignedIn = false;

  //Initial state
  @override
  void initState() {
    super.initState();
    cloudFirestore.getSignedInStatus().then((isSignedIn) {
      _isSignedIn = isSignedIn;
    });
  }

  //User interface: Root screen
  @override
  Widget build(BuildContext context) {
    if (!_isSignedIn) {
      routes.routeWelcomeScreen(context);
    } else if (_isSignedIn) {
      routes.routeHomeScreen(context);
    } else {
      interfaceStandards.showWaitingScreen();
    }
  }
}

class Routes {
  //Mechanics: Route pop
  void routePop(BuildContext context) {
    Navigator.pop(context);
  }

  //Mechanics: Route to Welcome screen
  void routeWelcomeScreen(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => WelcomeScreen()));
  }

  //Mechanics: Route to Login screen
  void routeLoginScreen(BuildContext context, bool _isSignIn) {
    Navigator.push(
        context, AnimationStandards().welcomePageTransition(_isSignIn));
  }

  //Mechanics: Route to Forgot Password screen
  void routeForgotPasswordScreen(BuildContext context) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => ForgotPasswordScreen()));
  }

  //Mecahnics: Route to Intro screen
  void routeIntroScreen(BuildContext context, String _email, String _password) {
    Navigator.pop(context);
    Navigator.pop(context);
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => IntroScreen(
                slides: InterfaceStandards().slideCreation(context),
                email: _email,
                password: _password)));
  }

  //Mechanics: Route to Home screen
  void routeHomeScreen(BuildContext context) {
    Navigator.pop(context);
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => HomeScreen()));
  }
}
