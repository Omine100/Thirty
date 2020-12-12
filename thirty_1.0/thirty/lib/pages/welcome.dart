import 'package:flutter/material.dart';
import 'package:thirty/services/appLocalizations.dart';
import 'package:page_transition/page_transition.dart';

import 'package:thirty/services/cloudFirestore.dart';
import 'package:thirty/standards/themes.dart';
import 'package:thirty/standards/themesGradients.dart';
import 'package:thirty/standards/interfaceStandards.dart';
import 'package:thirty/standards/animationStandards.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  //Class initialization
  CloudFirestore cloudFirestore = new CloudFirestore();
  Themes themes = new Themes();
  ThemesGradients themesGradients = new ThemesGradients();
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
        color: isSignIn
            ? themes.getColor(context, "welcomeSignInButtonColor")
            : themes.getColor(context, "welcomeSignInButtonColor"),
      ),
      child: Center(
        child: Text(
          isSignIn
              ? AppLocalizations.of(context).translate("welcomeSignInButton")
              : AppLocalizations.of(context).translate("welcomeSignUpButton"),
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
              top: themes.getPosition(
                  context, true, "welcomeBackgroundImagePosition"),
              child: interfaceStandards.parentCenter(
                context,
                Image(
                  image: AssetImage('lib/assets/welcomeBackgroundImage.png'),
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
                        Navigator.push(
                            context,
                            animationStandards
                                .welcomePageTransition(_isSignIn));
                      },
                      child: showSignInSignUpButton(
                          true,
                          themesGradients.textLinearGradient(
                            context,
                            themes.getColor(
                                context, "backgroundGradientTopRightColor"),
                            themes.getColor(
                                context, "backgroundGradientBottomLeftColor"),
                          ))),
                )),
            Positioned(
                top: themes.getPosition(
                    context, true, "welcomeSignUpButtonPosition"),
                child: interfaceStandards.parentCenter(
                  context,
                  GestureDetector(
                      onTap: () {
                        _isSignIn = false;
                        Navigator.push(
                            context,
                            animationStandards
                                .welcomePageTransition(_isSignIn));
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
              bottom: themes.getPosition(
                  context, true, "welcomeLanguageSelectorButtonPosition"),
              left: themes.getPosition(
                  context, false, "welcomeLanguageSelectorButtonPosition"),
              child: Container(
                height: themes.getDimension(
                    context, true, "welcomeLanguageSelectorButtonDimension"),
                width: themes.getDimension(
                    context, true, "welcomeLanguageSelectorButtonDimension"),
                child: Icon(
                  Icons.language,
                  color: themes.getColor(
                      context, "welcomeLanguageSelectorButtonColor"),
                  size: themes.getDimension(
                      context, true, "welcomeLanguageSelectorButtonDimension"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
