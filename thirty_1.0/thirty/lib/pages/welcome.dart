import 'package:flutter/material.dart';

import 'package:thirty/services/root.dart';
import 'package:thirty/services/cloudFirestore.dart';
import 'package:thirty/standards/themes.dart';
import 'package:thirty/standards/themesGradients.dart';
import 'package:thirty/standards/interfaceStandards.dart';
import 'package:thirty/pages/login.dart';

class WelcomeScreen extends StatefulWidget {
  WelcomeScreen({this.signInCallback});

  //Variable reference
  final VoidCallback signInCallback;

  @override
  State<StatefulWidget> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  //Class initialization
  CloudFirestore cloudFirestore = new CloudFirestore();
  Themes themes = new Themes();
  ThemesGradients themesGradients = new ThemesGradients();
  InterfaceStandards interfaceStandards = new InterfaceStandards();

  //Variable initialization
  bool _isLoading, _isSignIn, _isVisible;

  //Initial state
  @override
  void initState() {
    super.initState();
    _isSignIn = true;
    _isLoading = false;
    _isVisible = false;
  }

  //User interface: Show sign in or sign up button
  Widget showSignInSignUpButton(bool isSignIn, Shader linearGradient) {
    return new Container(
      height: themes.getDimension(
          context, true, "welcomeSignInSignUpButtonDimension"),
      width: themes.getDimension(
          context, false, "welcomeSignInSignUpButtonDimension"),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(90.0),
        color: Theme.of(context).colorScheme.welcomeSignInSignUpButtonColor,
      ),
      child: Center(
        child: Text(
          isSignIn ? "LOGIN" : "SIGN UP",
          style: TextStyle(
            foreground: Paint()..shader = linearGradient,
            fontSize: Theme.of(context)
                .textTheme
                .welcomeSignInSignUpButtonTextFontSize,
            fontWeight: Theme.of(context)
                .typography
                .welcomeSignInSignUpButtonTextFontWeight,
          ),
        ),
      ),
    );
  }

  //User interface: Welcome screen
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Container(
        height: themes.getDimension(context, true, "welcomeContainerDimension"),
        decoration: BoxDecoration(
            gradient: themesGradients.bodyLinearGradient(
                context,
                Theme.of(context).colorScheme.backgroundGradientTopLeftColor,
                Theme.of(context)
                    .colorScheme
                    .backgroundGradientBottomRightColor,
                false)),
        child: Stack(
          children: <Widget>[
            Positioned(
              top: themes.getPosition(context, true, "welcomeTitlePosition"),
              child: interfaceStandards.parentCenter(
                context,
                Text(
                  "WELCOME TO THIRTY",
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.welcomeTitleColor,
                      fontSize:
                          Theme.of(context).textTheme.welcomeTitleFontSize,
                      fontWeight:
                          Theme.of(context).typography.welcomeTitleFontWeight),
                ),
              ),
            ),
            Positioned(
                top: themes.getPosition(
                    context, true, "welcomeSignInButtonPosition"),
                child: interfaceStandards.parentCenter(
                  context,
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginScreen()));
                    },
                    child: showSignInSignUpButton(
                        true,
                        themesGradients.textLinearGradient(
                            context,
                            Theme.of(context)
                                .colorScheme
                                .backgroundGradientTopLeftColor,
                            Theme.of(context)
                                .colorScheme
                                .backgroundGradientBottomRightColor)),
                  ),
                )),
            Positioned(
                top: themes.getPosition(
                    context, true, "welcomeSignUpButtonPosition"),
                child: interfaceStandards.parentCenter(
                  context,
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginScreen()));
                    },
                    child: showSignInSignUpButton(
                        false,
                        themesGradients.textLinearGradient(
                            context,
                            Theme.of(context)
                                .colorScheme
                                .backgroundGradientTopLeftColor,
                            Theme.of(context)
                                .colorScheme
                                .backgroundGradientBottomRightColor)),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
