import 'package:flutter/material.dart';

import 'package:thirty/pages/login.dart';
import 'package:thirty/pages/home.dart';

//Method declarations
abstract class BaseRoutes {
  //Methods: Routes
  void RoutePop(BuildContext context);
  Widget RouteLogin(BuildContext context, bool isWidget, bool isSignIn);
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
      return LoginScreen();
    } else if (isSignedIn) {
      return HomeScreen();
    } else {
      //Return waiting screen
    }
  }
}
