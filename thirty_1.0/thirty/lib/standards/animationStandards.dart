import 'package:flutter/material.dart';
import 'package:animations/animations.dart';

import 'package:thirty/pages/login.dart';

class AnimationStandards {
  //User interface: Welcome shared axis transformation animation
  PageTransitionSwitcher welcomeSharedAxisAnimation(bool _isSignIn) {
    return PageTransitionSwitcher(
      duration: const Duration(milliseconds: 20000),
      reverse: false,
      transitionBuilder: (
        Widget child,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
      ) {
        return SharedAxisTransition(
          child: LoginScreen(
            isSignIn: _isSignIn,
          ),
          animation: animation,
          secondaryAnimation: secondaryAnimation,
          transitionType: SharedAxisTransitionType.horizontal,
        );
      },
      child: LoginScreen(
        isSignIn: _isSignIn,
      ),
    );
  }
}
