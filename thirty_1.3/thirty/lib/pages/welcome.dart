import 'package:flutter/material.dart';

import 'package:thirty/services/cloudFirestore.dart';
import 'package:thirty/services/routeNavigation.dart';
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
  RouteNavigation routeNavigation = new RouteNavigation();
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
        height:
            themes.getDimension(context, true, "welcomeSignInButtonDimension"),
        width:
            themes.getDimension(context, false, "welcomeSignInButtonDimension"),
        child: GestureDetector(
          onTap: () {
            animationStandards.welcomePageTransition(context, true);
          },
          child: interfaceStandards.parentCenter(
            context,
            Text(
              getTranslated(context, "welcomeSignInButton"),
              style: TextStyle(
                color: themes.getColor(context, "welcomeSignInButtonTextColor"),
                fontSize:
                    Theme.of(context).textTheme.welcomeSignInButtonTextFontSize,
                fontWeight: Theme.of(context)
                    .typography
                    .welcomeSignUpButtonTextFontWeight,
              ),
            ),
          ),
        ));
  }

  //USER INTERFACE: Show sign up button
  //DESCRIPTION: Basic widget method for the sign up button
  //OUTPUT: A button formatted properly for signing up
  Widget showSignUpButton() {
    return new Container(
      height:
          themes.getDimension(context, true, "welcomeSignUpButtonDimension"),
      width:
          themes.getDimension(context, false, "welcomeSignUpButtonDimension"),
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
            Text(
              getTranslated(context, "welcomeSignUpButton"),
              style: TextStyle(
                foreground: (Paint()
                  ..shader = gradients.signUpButtonGradient(context)),
                fontSize:
                    Theme.of(context).textTheme.welcomeSignUpButtonTextFontSize,
                fontWeight: Theme.of(context)
                    .typography
                    .welcomeSignUpButtonTextFontWeight,
              ),
            )),
      ),
    );
  }

  //USER INTERFACE: Show divider and Google sign in button
  //DESCRIPTION: Display a Google icon and call cloudFirestore.dart function
  //OUTPUT: Widget for divider and Google sign in button
  Widget showGoogleSignInButtonEnvironment() {
    return interfaceStandards.parentCenter(
      context,
      Column(
        children: [
          Container(
            padding: EdgeInsets.only(bottom: 10),
            width: themes.getDimension(
                context, false, "welcomeGoogleSignInDividerDimension"),
            child: Divider(
              color:
                  themes.getColor(context, "welcomeGoogleSignInDividerColor"),
              height: themes.getDimension(
                  context, true, "welcomeGoogleSignInDividerDimension"),
            ),
          ),
          GestureDetector(
            onTap: () {
              cloudFirestore.signInGoogle().then((_newUser) => {
                    if (_newUser)
                      {routeNavigation.RouteHome(context)}
                    else
                      {
                        // routeNavigation.RouteIntro();
                      }
                  });
            },
            child: Container(
              padding: EdgeInsets.all(7.5),
              height: themes.getDimension(
                  context, true, "welcomeGoogleSignInButtonDimension"),
              width: themes.getDimension(
                  context, true, "welcomeGoogleSignInButtonDimension"),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(360),
                color:
                    themes.getColor(context, "welcomeGoogleSignInButtonColor"),
              ),
              child: Image(
                image: AssetImage('lib/assets/googleLogo.png'),
              ),
            ),
          ),
        ],
      ),
    );
  }

  //USER INTERFACE: WELCOME SCREEN
  Widget build(BuildContext context) {
    //VARIABLE INITIALIZATION
    isDark = themes.checkDarkTheme(context);

    //USER INTERFACE: Welcome screen
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
                    context, showSignUpButton())),
            Positioned(
              top: themes.getPosition(
                  context, true, "welcomeGoogleSignInButtonPosition"),
              child: showGoogleSignInButtonEnvironment(),
            ),
            Positioned(
                top: themes.getPosition(
                    context, true, "welcomeSignInButtonPosition"),
                child: interfaceStandards.parentCenter(
                    context, showSignInButton())),
            Positioned(
                top: themes.getPosition(
                    context, true, "welcomeThemeSelectorButtonPosition"),
                right: themes.getPosition(
                    context, false, "welcomeThemeSelectorButtonPosition"),
                child: interfaceStandards.parentCenter(
                    context, interfaceStandards.themeSelector(context))),
            Positioned(
                bottom: themes.getPosition(
                    context, true, "welcomeLanguageSelectorButtonPosition"),
                left: themes.getPosition(
                    context, false, "welcomeLanguageSelectorButtonPosition"),
                child: interfaceStandards.languageSelector(context)),
          ],
        ),
      ),
    );
  }
}
