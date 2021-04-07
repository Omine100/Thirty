import 'package:flutter/material.dart';

import 'package:thirty/services/cloudFirestore.dart';
import 'package:thirty/standards/languageStandards.dart';
import 'package:thirty/standards/themes.dart';
import 'package:thirty/standards/gradientStandards.dart';
import 'package:thirty/standards/animationStandards.dart';
import 'package:thirty/standards/interfaceStandards.dart';
import 'package:thirty/standards/methodStandards.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  //CLASS INITIALIZATION
  CloudFirestore cloudFirestore = new CloudFirestore();
  Themes themes = new Themes();
  ThemeNotifier themeNotifier = new ThemeNotifier();
  GradientStandards gradientStandards = new GradientStandards();
  Gradients gradients = new Gradients();
  AnimationStandards animationStandards = new AnimationStandards();
  InterfaceStandards interfaceStandards = new InterfaceStandards();
  MethodStandards methodStandards = new MethodStandards();

  //VARIABLE INITIALIZATION
  bool isDark;

  //INITIAL STATE
  //DESCRIPTION: Gets isDark status prior to the application loading
  void initState() {
    super.initState();
    isDark = themes.checkDarkTheme(context);
  }

  //USER INTERFACE: Show sign in or sign up button
  //DESCRIPTION: Basic widget method, but I think that this makes the file smaller
  //          because we aren't having to have all of these lines of code for two
  //          widgets that are the same minus a couple lines of code. I thought
  //          about putting this in interfaceStandards, but we only have this
  //          right here. I want the signUp button to just be text I think, then
  //          have the other one look like an actual button
  //BOOLEAN INPUT: 'isSignIn' for deciding what to format the button as
  //OUTPUT: A button formatted properly for either signing in or signing up
  Widget showSignInSignUpButton(bool isSignIn) {
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
                  : (Paint()..shader = gradients.signUpButtonGradient(context)),
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

  //USER INTERFACE: WELCOME SCREEN
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Container(
        height: themes.getDimension(context, true, "welcomeContainerDimension"),
        width: themes.getDimension(context, false, "welcomeContainerDimension"),
        decoration:
            BoxDecoration(gradient: gradients.welcomeScreenGradient(context)),
        child: Stack(
          children: <Widget>[
            Positioned(),
            Positioned(),
            Positioned(),
            Positioned(),
            Positioned(),
            Positioned(),
          ],
        ),
      ),
    );
  }
}
