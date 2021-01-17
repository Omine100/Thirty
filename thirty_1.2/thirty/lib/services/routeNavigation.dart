import 'package:flutter/material.dart';

import 'package:thirty/pages/login.dart';
import 'package:thirty/pages/home.dart';

//Method declarations
abstract class BaseRoutes {
  //Methods: Routes
  void RoutePop(BuildContext context);
  void RouteLogin(BuildContext context);
  void RouteHome(BuildContext context);

  //Methods: Route managements
  Widget NavigateLogin(BuildContext context, bool isSignedIn);
}

class RouteNavigation implements BaseRoutes {
  //Mechanics: Route pop
  void RoutePop(BuildContext context) {
    Navigator.pop(context);
  }

  //Mechanics: Routes to login screen
  void RouteLogin(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => LoginScreen()));
  }

  //Mechanics: Routes to home screen
  void RouteHome(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => HomeScreen()));
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
