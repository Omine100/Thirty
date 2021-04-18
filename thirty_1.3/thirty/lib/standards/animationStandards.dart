import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import 'package:thirty/services/routeNavigation.dart';

class AnimationStandards {
  //CLASS INITIALIZATION
  RouteNavigation routeNavigation = new RouteNavigation();

  //USER INTERFACE: Welcome page transition
  //DESCRIPTION: Simple animation between the welcome screen and the login screen
  //BOOLEAN INPUT: '_isSignIn' used to forward to the new screen
  //OUTPUT: New page
  PageTransition welcomePageTransition(BuildContext context, bool isSignIn) {
    return PageTransition(
        duration: const Duration(milliseconds: 750),
        curve: Curves.easeInOutCirc,
        type: PageTransitionType.scale,
        alignment: Alignment.bottomCenter,
        child: routeNavigation.RouteHome(context)); //Need to change to RouteLogin
  }
}
