import 'package:flutter/material.dart';

import 'package:thirty/pages/welcome.dart';
import 'package:thirty/pages/login.dart';
import 'package:thirty/pages/forgotPassword.dart';
import 'package:thirty/pages/intro.dart';
import 'package:thirty/pages/home.dart';

//METHOD DECLARATIONS
abstract class BaseRoutes {
  //METHODS: Routes
  void routePop(BuildContext context);
  Widget routeLogin(BuildContext context, bool isSignIn);
  void routeForgotPassword(BuildContext context);
  void routeIntro(BuildContext context);
  void routeHome(BuildContext context);

  //METHODS: Route managements
  Widget navigateLogin(BuildContext context, bool isSignedIn);
}

class RouteNavigation implements BaseRoutes {
  //MECHANICS: Route pop
  //DESCRIPTION: Takes the navigator stack and pops the top one off
  void routePop(BuildContext context) {
    Navigator.pop(context);
  }

  //MECHANICS: Routes to login screen
  //BOOLEAN INPUT: 'isSignIn' allows for setting up the screen for either signIn
  //            or SignUp
  //OUTPUT: The output is an empty container, but I am just treating this as a 
  //      null to get rid of some problems with the animationStandards.dart 
  //      reference method
  Widget routeLogin(BuildContext context, bool isSignIn) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => LoginScreen(
                  isSignIn: isSignIn,
                )));
                return Container();
  }

  //MECHANICS: Routes to forgot password screen
  void routeForgotPassword(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => ForgotPasswordScreen()));
  }

  //MECHANICS: Routes to intro screen
  void routeIntro(BuildContext context) {
    while (Navigator.canPop(context)) {
      routePop(context);
    }
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => IntroScreen()));
  }

  //MECHANICS: Routes to home screen
  void routeHome(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => HomeScreen()));
  }

  //MECHANICS: Navigates to first screen
  //BOOLEAN INPUT: 'isSignedIn' for deciding which screen to display where true
  //            shows HomeScreen and false shows WelcomeScreen
  //OUTPUT: Returns a specific screen depending on the value of 'isSignedIn'
  Widget navigateLogin(BuildContext context, bool isSignedIn) {
    if (!isSignedIn) {
      return WelcomeScreen();
    } else if (isSignedIn) {
      return HomeScreen();
    }
    return Container();
  }
}
