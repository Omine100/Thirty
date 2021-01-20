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
  //Class initialization
  CloudFirestore cloudFirestore = new CloudFirestore();
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
          children: <Widget>[
            Positioned(
              top: themes.checkDarkTheme(context)
                  ? themes.getPosition(
                      context, true, "welcomeBackgroundDarkThemeImagePosition")
                  : themes.getPosition(context, true,
                      "welcomeBackgroundLightThemeImagePosition"),
              left: themes.checkDarkTheme(context)
                  ? themes.getPosition(
                      context, false, "welcomeBackgroundDarkThemeImagePosition")
                  : themes.getPosition(context, false,
                      "welcomeBackgroundLightThemeImagePosition"),
              child: interfaceStandards.parentCenter(
                  context,
                  Image(
                    image: themes.checkDarkTheme(context)
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
              child: interfaceStandards.parentCenter(
                  context,
                  interfaceStandards.showTitle(
                      context, getTranslated(context, "welcomeTitle"))),
            ),
            Positioned(
              top: themes.getPosition(
                  context, true, "welcomeSignInButtonPosition"),
              child: interfaceStandards.parentCenter(
                  context,
                  GestureDetector(
                    onTap: () {
                      animationStandards.welcomePageTransition(context, true);
                    },
                    child: showSignInSignUpButton(true, null),
                  )),
            ),
            Positioned(
              top: themes.getPosition(
                  context, true, "welcomeSignUpButtonPosition"),
              child: interfaceStandards.parentCenter(
                  context,
                  GestureDetector(
                    onTap: () {
                      animationStandards.welcomePageTransition(context, false);
                    },
                    child: showSignInSignUpButton(
                        false,
                        gradientStandards.textLinearGradient(
                            context,
                            themes.getColor(
                                context, "backgroundGradientTopRightColor"),
                            themes.getColor(
                                context, "backgroundGradientBottomLeftColor"))),
                  )),
            ),
            Positioned(
                top: themes.getPosition(context, true,
                    "interfaceStandardsThemeSelectorButtonPosition"),
                right: themes.getPosition(context, false,
                    "interfaceStandardsThemeSelectorButtonPosition"),
                child: interfaceStandards.parentCenter(
                    context, interfaceStandards.themeSelector(context))),
            Positioned(
                bottom: themes.getPosition(context, true,
                    "interfaceStandardsLanguageSelectorButtonPosition"),
                left: themes.getPosition(context, false,
                    "interfaceStandardsLanguageSelectorButtonPosition"),
                child: interfaceStandards.languageSelector(context)),
          ],
        ),
      ),
    );
  }
}
