import 'package:flutter/material.dart';
import 'package:thirty/services/appLocalizations.dart';

import 'package:thirty/services/cloudFirestore.dart';
import 'package:thirty/services/routeNavigation.dart';
import 'package:thirty/languages/languages.dart';
import 'package:thirty/standards/themes.dart';
import 'package:thirty/standards/themesGradients.dart';
import 'package:thirty/standards/methodStandards.dart';
import 'package:thirty/standards/interfaceStandards.dart';
import 'package:thirty/standards/animationStandards.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  //Class initialization
  CloudFirestore cloudFirestore = new CloudFirestore();
  Routes routes = new Routes();
  Themes themes = new Themes();
  ThemeNotifier themeNotifier = new ThemeNotifier();
  ThemesGradients themesGradients = new ThemesGradients();
  MethodStandards methodStandards = new MethodStandards();
  InterfaceStandards interfaceStandards = new InterfaceStandards();
  AnimationStandards animationStandards = new AnimationStandards();

  //Variable initialization
  bool _isLoading, _isSignIn, _isVisible;

  //Mechanics: Initial state
  @override
  void initState() {
    super.initState();
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
        color: themes.getColor(context,
            isSignIn ? "welcomeSignInButtonColor" : "welcomeSignUpButtonColor"),
      ),
      child: Center(
        child: Text(
          isSignIn
              ? getTranslated(context, "welcomeSignInButton")
              : getTranslated(context, "welcomeSignUpButton"),
          style: TextStyle(
            foreground: isSignIn
                ? (Paint()
                  ..color =
                      themes.getColor(context, "welcomeSignInButtonTextColor"))
                : (Paint()..shader = linearGradient),
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
                ),
              ),
            ),
            Positioned(
              top: themes.getPosition(context, true, "welcomeTitlePosition"),
              child: interfaceStandards.parentCenter(
                context,
                interfaceStandards.showTitle(context, "welcomeTitle"),
              ),
            ),
            Positioned(
                top: themes.getPosition(
                    context, true, "welcomeSignInButtonPosition"),
                child: interfaceStandards.parentCenter(
                  context,
                  GestureDetector(
                      onTap: () {
                        _isSignIn = true;
                        routes.routeLoginScreen(context, _isSignIn);
                      },
                      child: showSignInSignUpButton(true, null)),
                )),
            Positioned(
                top: themes.getPosition(
                    context, true, "welcomeSignUpButtonPosition"),
                child: interfaceStandards.parentCenter(
                  context,
                  GestureDetector(
                      onTap: () {
                        _isSignIn = false;
                        routes.routeLoginScreen(context, _isSignIn);
                      },
                      child: showSignInSignUpButton(
                          false,
                          themesGradients.textLinearGradient(
                            context,
                            themes.getColor(
                                context, "backgroundGradientTopRightColor"),
                            themes.getColor(
                                context, "backgroundGradientBottomLeftColor"),
                          ))),
                )),
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
