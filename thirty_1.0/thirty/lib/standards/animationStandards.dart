import 'package:flutter/material.dart';
import 'package:animations/animations.dart';

import 'package:thirty/pages/login.dart';

class AnimationStandards {
  //User interface: Welcome shared axis transformation animation
  PageTransitionSwitcher welcomeSharedAxisAnimation(bool _isSignIn) {
    PageTransitionSwitcher pageTransitionSwitcher = new PageTransitionSwitcher(
      duration: const Duration(milliseconds: 200),
      reverse: false,
      transitionBuilder: (Widget child, Animation<double> animation,
          Animation<double> secondaryAnimation) {
        return SharedAxisTransition(
          child: child,
          animation: animation,
          secondaryAnimation: secondaryAnimation,
          transitionType: SharedAxisTransitionType.horizontal,
        );
      },
      child: LoginScreen(
        isSignIn: _isSignIn,
      ),
    );
    return pageTransitionSwitcher;
  }
}
