import 'package:flutter/material.dart';

import 'package:thirty/standards/interfaceStandards.dart';
import 'package:thirty/pages/welcome.dart';
import 'package:thirty/pages/login.dart';
import 'package:thirty/pages/forgotPassword.dart';
import 'package:thirty/pages/intro.dart';
import 'package:thirty/pages/home.dart';

//Method declarations
abstract class BaseRoutes {
  //Methods: Routes
  void RoutePop(BuildContext context);
  Widget RouteLogin(BuildContext context, bool isSignIn);
  Widget RouteForgotPassword(BuildContext context);
  Widget RouteIntro(BuildContext context); //Don't pass email, call Firestore?
  Widget RouteHome(BuildContext context);

  //Methods: Route managements
  Widget NavigateLogin(BuildContext context, bool isSignedIn);
}

class RouteNavigation implements BaseRoutes {
  //Mechanics: Route app
  void RoutePop(BuildContext context) {
    Navigator.pop(context);
  }

  //Mechanics: Routes to login screen
  Widget RouteLogin(BuildContext context, bool isSignIn) {
    Navigator.push(context, LoginScreen(isSignIn: isSignIn));
  }

  //Mechanics: Routes to forgot password screen
  Widget RouteForgotPassword(BuildContext context) {
    Navigator.push(context, ForgotPasswordScreen());
  }

  //Mechanics: Routes to intro screen
  Widget RouteIntro(BuildContext context) {
    while (Navigator.canPop(context)) {
      RoutePop(context);
    }
    Navigator.push(context, IntroScreen());
  }

  //Mechanics: Routes to home screen
  Widget RouteHome(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => HomeScreen()));
  }

  //Mechanics: Navigates to first screen
  Widget NavigateLogin(BuildContext context, bool isSignedIn) {
    if (!isSignedIn) {
      return WelcomeScreen();
    } else if (isSignedIn) {
      return HomeScreen();
    } else {
      return InterfaceStandards().showWaitingScreen();
    }
  }
}
