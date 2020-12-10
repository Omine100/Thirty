import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import 'package:thirty/pages/login.dart';

class AnimationStandards {
  //User interface: Welcome page transition
  PageTransition welcomePageTransition(bool _isSignIn) {
    return PageTransition(
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOutCirc,
      type: PageTransitionType.scale,
      alignment: Alignment.bottomCenter,
      child: LoginScreen(
        isSignIn: _isSignIn,
      ),
    );
  }
}
