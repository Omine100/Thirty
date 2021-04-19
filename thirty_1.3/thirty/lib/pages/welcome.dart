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

  //VARIABLE DECLARATION
  bool isDark;

  //USER INTERFACE: Show sign in button
  //DESCRIPTION: Basic widget method for the sign in text button
  //OUTPUT: A text widget with a gesture detector
  Widget showSignInButton() {
    return new Container(
      height: themes.getDimension(context, true, "welcomeSignInButtonDimension"),
      width: themes.getDimension(context, false, "welcomeSignInButtonDimension"),
      child: GestureDetector(
        onTap: () {
           animationStandards.welcomePageTransition(context, true);
        },
        child: interfaceStandards.parentCenter(context,
          Text(
            getTranslated(context, "welcomeSignInButton"),
            style: TextStyle(
              color: themes.getColor(context, "welcomeSignInButtonTextColor"),
              fontSize: Theme.of(context).textTheme.welcomeSignInButtonTextFontSize,
              fontWeight: Theme.of(context).typography.welcomeSignUpButtonTextFontWeight,
            ),
          ),
        ),
      )
    );
  }

  //USER INTERFACE: Show sign up button
  //DESCRIPTION: Basic widget method for the sign up button
  //OUTPUT: A button formatted properly for signing up
  Widget showSignUpButton() {
    return new Container(
      height: themes.getDimension(
          context, true, "welcomeSignUpButtonDimension"),
      width: themes.getDimension(
          context, false, "welcomeSignUpButtonDimension"),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(90.0),
        color: themes.getColor(context, "welcomeSignUpButtonColor"),
      ),
      child: GestureDetector(
        onTap: () {
           animationStandards.welcomePageTransition(context, false);
        },
        child: interfaceStandards.parentCenter(
            context,
            Text(getTranslated(context, "welcomeSignUpButton"),
              style: TextStyle(
                foreground:(Paint()..shader = gradients.signUpButtonGradient(context)),
                fontSize: Theme.of(context)
                    .textTheme
                    .welcomeSignUpButtonTextFontSize,
                fontWeight: Theme.of(context)
                    .typography
                    .welcomeSignUpButtonTextFontWeight,
              ),
            )),
      ),
    );
  }

  //USER INTERFACE: WELCOME SCREEN
  Widget build(BuildContext context) {
    //VARIABLE INITIALIZATION
    isDark = themes.checkDarkTheme(context);

    //USER INTERFACE: WELCOME SCREEN
    return new Scaffold(
      body: Container(
        height: themes.getDimension(context, true, "welcomeContainerDimension"),
        width: themes.getDimension(context, false, "welcomeContainerDimension"),
        decoration:
            BoxDecoration(gradient: gradients.welcomeScreenGradient(context)),
        child: Stack(
          children: <Widget>[
            Positioned(
              top: isDark
                  ? themes.getPosition(
                      context, true, "welcomeBackgroundDarkThemeImagePosition")
                  : themes.getPosition(context, true,
                      "welcomeBackgroundLightThemeImagePosition"),
              left: isDark
                  ? themes.getPosition(
                      context, false, "welcomeBackgroundDarkThemeImagePosition")
                  : themes.getPosition(context, false,
                      "welcomeBackgroundLightThemeImagePosition"),
              child: interfaceStandards.parentCenter(
                  context,
                  Image(
                    image: isDark
                        ? AssetImage(
                            'lib/assets/welcomeBackgroundDarkThemeImage.png')
                        : AssetImage(
                            'lib/assets/welcomeBackgroundLightThemeImage.png'),
                    height: themes.getDimension(
                        context, true, "welcomeBackgroundImageDimension"),
                    width: themes.getDimension(
                        context, false, "welcomeBackgroundImageDimension"),
                  )),
            ),
            Positioned(
              top: themes.getPosition(context, true, "welcomeTitlePosition"),
              child: interfaceStandards.parentCenter(context,
                  interfaceStandards.showTitle(context, "welcomeTitle")),
            ),
            Positioned(
              top: themes.getPosition(
                  context, true, "welcomeSignUpButtonPosition"),
              child: interfaceStandards.parentCenter(
                  context,
                  showSignUpButton())
            ),
            Positioned(
              top: themes.getPosition(
                  context, true, "welcomeSignInButtonPosition"),
              child: interfaceStandards.parentCenter(
                  context,
                  showSignInButton())
            ),
            Positioned(
                top: themes.getPosition(context, true,
                    "welcomeThemeSelectorButtonPosition"),
                right: themes.getPosition(context, false,
                    "welcomeThemeSelectorButtonPosition"),
                child: interfaceStandards.parentCenter(
                    context, interfaceStandards.themeSelector(context))),
            Positioned(
                bottom: themes.getPosition(context, true,
                    "welcomeLanguageSelectorButtonPosition"),
                left: themes.getPosition(context, false,
                    "welcomeLanguageSelectorButtonPosition"),
                child: interfaceStandards.languageSelector(context)),
          ],
        ),
      ),
    );
  }
}
