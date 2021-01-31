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
  Widget RouteLogin(BuildContext context, bool isWidget, bool isSignIn);
  Widget RouteForgotPassword(BuildContext context, bool isWidget);
  Widget RouteIntro(
      BuildContext context, bool isWidget, String email, String password);
  Widget RouteHome(BuildContext context, bool isWidget);

  //Methods: Route managements
  Widget NavigateLogin(BuildContext context, bool isSignedIn);
}

class RouteNavigation implements BaseRoutes {
  //Mechanics: Route pop
  void RoutePop(BuildContext context) {
    Navigator.pop(context);
  }

  //Mechanics: Routes to login screen
  Widget RouteLogin(BuildContext context, bool isWidget, bool isSignIn) {
    if (!isWidget) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => LoginScreen(
                    isSignIn: isSignIn,
                  )));
    } else {
      return LoginScreen(
        isSignIn: isSignIn,
      );
    }
  }

  //Mechanics: Routes to forgot password screen
  Widget RouteForgotPassword(BuildContext context, bool isWidget) {
    if (!isWidget) {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => ForgotPasswordScreen()));
    } else {
      return ForgotPasswordScreen();
    }
  }

  //Mechanics: Routes to intro screen
  Widget RouteIntro(
      BuildContext context, bool isWidget, String email, String password) {
    if (!isWidget) {
      if (Navigator.canPop(context)) {
        RoutePop(context);
      }
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => IntroScreen()));
    }
  }

  //Mechanics: Routes to home screen
  Widget RouteHome(BuildContext context, bool isWidget) {
    if (!isWidget) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => HomeScreen()));
    } else {
      return HomeScreen();
    }
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
