import 'package:flutter/material.dart';

import 'package:thirty/services/cloudFirestore.dart';
import 'package:thirty/services/routeNavigation.dart';
import 'package:thirty/standards/languageStandards.dart';
import 'package:thirty/standards/themes.dart';
import 'package:thirty/standards/gradientStandards.dart';
import 'package:thirty/standards/animationStandards.dart';
import 'package:thirty/standards/interfaceStandards.dart';
// import 'package:thirty/standards/languageStandards.dart'; maybe don't need this?
import 'package:thirty/standards/methodStandards.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  //Class initialization
  CloudFirestore cloudFirestore = new CloudFirestore();
  RouteNavigation routeNavigation = new RouteNavigation();
  Themes themes = new Themes();
  ThemeNotifier themeNotifier = new ThemeNotifier();
  GradientStandards gradientStandards = new GradientStandards();
  AnimationStandards animationStandards = new AnimationStandards();
  InterfaceStandards interfaceStandards = new InterfaceStandards();
  MethodStandards methodStandards = new MethodStandards();

  //User interface: Show sign in or sign up button
  Widget showSignInSignUpButton(bool isSignIn, Shader linearGradient) {
    return new Container(
      height: themes.getDimension(
          context, true, "welcomeSignInSignUpButtonDimension"),
      width: themes.getDimension(
          context, false, "welcomeSignInSignUpButtonDimension"),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(90.0),
        color: themes.getColor(context,
            isSignIn ? "welcomeSignInButtonColor" : "welcomeSignUpButtonColor"),
      ),
      child: interfaceStandards.parentCenter(
          context,
          Text(
            isSignIn
                ? getTranslated(context, "welcomeSignInButton")
                : getTranslated(context, "welcomeSignUpButton"),
            style: TextStyle(
              foreground: isSignIn
                  ? (Paint()
                    ..color = themes.getColor(
                        context, "welcomeSignInButtonTextColor"))
                  : (Paint()..shader = linearGradient),
              fontSize: Theme.of(context)
                  .textTheme
                  .welcomeSignInSignUpButtonTextFontSize,
              fontWeight: Theme.of(context)
                  .typography
                  .welcomeSignInSignUpButtonTextFontWeight,
            ),
          )),
    );
  }

  //User interface: Welcome screen
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Container(
        height: themes.getDimension(context, true, "welcomeContainerDimension"),
        decoration: BoxDecoration(
            gradient: gradientStandards.bodyLinearGradient(
                context,
                themes.getColor(context, "backgroundGradientTopRightColor"),
                themes.getColor(context, "backgroundGradientBottomLeftColor"),
                false)),
        child: Stack(
          children: <Widget>[],
        ),
      ),
    );
  }
}
