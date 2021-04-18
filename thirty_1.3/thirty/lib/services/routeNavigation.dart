import 'package:flutter/material.dart';

import 'package:thirty/standards/interfaceStandards.dart';
import 'package:thirty/pages/welcome.dart';
import 'package:thirty/pages/login.dart';
import 'package:thirty/pages/forgotPassword.dart';
import 'package:thirty/pages/intro.dart';
import 'package:thirty/pages/home.dart';

//METHOD DECLARATIONS
abstract class BaseRoutes {
  //METHODS: Routes
  void RoutePop(BuildContext context);
  // Widget RouteLogin(BuildContext context, bool isSignIn);
  // Widget RouteForgotPassword(BuildContext context);
  // Widget RouteIntro(BuildContext context); //Don't pass email, call Firestore?
  Widget RouteHome(BuildContext context);

  //METHODS: Route managements
  Widget NavigateLogin(BuildContext context, bool isSignedIn);
}

class RouteNavigation implements BaseRoutes {
  //MECHANICS: Route pop
  //DESCRIPTION: Takes the navigator stack and pops the top one off
  void RoutePop(BuildContext context) {
    Navigator.pop(context);
  }

  //MECHANICS: Routes to login screen
  //BOOLEAN INPUT: 'isSignIn' allows for setting up the screen for either signIn
  //            or SignUp
  // Widget RouteLogin(BuildContext context, bool isSignIn) {
  //   Navigator.push(context, LoginScreen(isSignIn: isSignIn));
  // }

  //MECHANICS: Routes to forgot password screen
  // Widget RouteForgotPassword(BuildContext context) {
  //   Navigator.push(context, ForgotPasswordScreen());
  // }

  //MECHANICS: Routes to intro screen
  // Widget RouteIntro(BuildContext context) {
  //   while (Navigator.canPop(context)) {
  //     RoutePop(context);
  //   }
  //   Navigator.push(context, IntroScreen());
  // }

  //MECHANICS: Routes to home screen
  Widget RouteHome(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => HomeScreen()));
  }

  //MECHANICS: Navigates to first screen
  //BOOLEAN INPUT: 'isSignedIn' for deciding which screen to display where true
  //            shows HomeScreen and false shows WelcomeScreen
  //OUTPUT: Returns a specific screen depending on the value of 'isSignedIn'
  Widget NavigateLogin(BuildContext context, bool isSignedIn) {
    if (!isSignedIn) {
      return WelcomeScreen();
    } else if (isSignedIn) {
      return HomeScreen();
    }
  }
}
