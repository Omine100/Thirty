import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import 'package:thirty/services/routeNavigation.dart';

class AnimationStandards {
  //Class initialization
  RouteNavigation routeNavigation = new RouteNavigation();

  //User interfacce: Welcome page transition
  PageTransition welcomePageTransition(BuildContext context, bool _isSignIn) {
    return PageTransition(
        duration: const Duration(milliseconds: 750),
        curve: Curves.easeInOutCirc,
        type: PageTransitionType.scale,
        alignment: Alignment.bottomCenter,
        child: routeNavigation.RouteLogin(context, _isSignIn));
  }
}
