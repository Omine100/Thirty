import 'package:flutter/material.dart';

import 'package:thirty/services/routeNavigation.dart';
import 'package:thirty/services/cloudFirestore.dart';
import 'package:thirty/standards/languageStandards.dart';
import 'package:thirty/standards/themes.dart';
import 'package:thirty/standards/gradientStandards.dart';
import 'package:thirty/standards/interfaceStandards.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({this.isSignIn});

  //Variable references
  final bool isSignIn;

  @override
  State<StatefulWidget> createState() => new _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  //Class initialization
  RouteNavigation routeNavigation = new RouteNavigation();
  CloudFirestore cloudFirestore = new CloudFirestore();
  Themes themes = new Themes();
  GradientStandards gradientStandards = new GradientStandards();
  InterfaceStandards interfaceStandards = new InterfaceStandards();

  //Variable initialization
  final _formKey = GlobalKey<FormState>();
  String _name, _email, _password;
  bool _isSignIn, _isVisible = false;

  //Mechanics: Initial state
  void initState() {
    super.initState();
    _isSignIn = widget.isSignIn;
  }

  //Mechanics: Validate and submit user information
  void validateAndSubmit(GlobalKey<ScaffoldState> scaffold) async {
    final form = _formKey.currentState;
    setState(() {
      interfaceStandards.showProgress(context);
    });
    if (form.validate()) {
      form.save();
      try {
        if (_isSignIn) {
          await cloudFirestore.signIn(_email, _password);
          routeNavigation.RouteHome(context, false);
        } else {
          await cloudFirestore.signUp(_email, _password);
          await cloudFirestore.createNameData(_name);
          cloudFirestore.sendEmailVerification();
          routeNavigation.RouteIntro(context, false, _email, _password);
        }
      } catch (e) {
        print("Error: $e");
        setState(() {
          form.reset();
        });
      }
    }
  }

  //User interface: Show visible button
  Widget showVisibilityButton() {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isVisible = !_isVisible;
        });
      },
      child: Icon(
        _isVisible ? Icons.visibility : Icons.visibility_off,
        color: themes.getColor(context, "loginVisiblityButtonColor"),
      ),
    );
  }

  //User interface: Show alternative button
  Widget showAlternativeButton() {
    return new Text(
      _isSignIn
          ? getTranslated(context, "loginAlternativeSignUp")
          : getTranslated(context, "loginAlternativeSignIn"),
      style: TextStyle(
        color: themes.getColor(context, "loginAlternativeTextColor"),
        fontSize:
            Theme.of(context).textTheme.loginAlternativeButtonTextFontSize,
        fontWeight:
            Theme.of(context).typography.loginAlternativeButtonTextFontWeight,
      ),
    );
  }

  //User interface: Show forgot password button
  Widget showForgotPasswordButton() {
    return new Text(
      getTranslated(context, "loginForgotPassword"),
      style: TextStyle(
        color: themes.getColor(context, "loginForgotPasswordButtonTextColor"),
        fontSize:
            Theme.of(context).textTheme.loginForgotPasswordButtonTextFontSize,
        fontWeight: Theme.of(context)
            .typography
            .loginForgotPasswordButtonTextFontWeight,
      ),
    );
  }

  //User interface: Show progression button
  Widget showProgressionButton() {
    return new Container(
      height: 50.0,
      width: 50.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(360.0),
        color: themes.getColor(context, "loginProgressionButtonColor"),
      ),
      child: Icon(
        Icons.arrow_forward_ios,
        color: themes.getColor(context, "loginProgressionButtonIconColor"),
      ),
    );
  }

  //User interface: Login screen
  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
    return new Scaffold(
      key: scaffoldKey,
      body: Container(
        height: themes.getDimension(context, true, "loginContainerDimension"),
        decoration: BoxDecoration(
            gradient: gradientStandards.bodyLinearGradient(
                context,
                themes.getColor(context, "backgroundGradientTopRightColor"),
                themes.getColor(context, "backgroundGradientBottomLeftColor"),
                false)),
        child: Stack(
          children: [
            Positioned(
              top: themes.getPosition(context, true, "loginTitlePosition"),
              child: _isSignIn
                  ? interfaceStandards.showTitle(context, "loginSignInTitle")
                  : interfaceStandards.showTitle(context, "loginSignUpTitle"),
            ),
            SingleChildScrollView(),
            Positioned(
              top: themes.getPosition(
                  context, true, "loginProgressionButtonPosition"),
              child: interfaceStandards.parentCenter(
                  context,
                  GestureDetector(
                    onTap: () {
                      validateAndSubmit(scaffoldKey);
                    },
                    child: showProgressionButton(),
                  )),
            ),
            Positioned(
              top: themes.getPosition(
                  context, true, "loginAlternativeButtonPosition"),
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _isSignIn = !_isSignIn;
                  });
                },
                child: interfaceStandards.parentCenter(
                    context, showAlternativeButton()),
              ),
            ),
            Positioned(
              top: themes.getPosition(
                  context, true, "loginForgotPasswordButtonPosition"),
              left: themes.getPosition(
                  context, false, "loginForgotPasswordButtonPosition"),
              child: GestureDetector(
                onTap: () {
                  routeNavigation.RouteForgotPassword(context, false);
                },
                child: interfaceStandards.parentCenter(context,
                    _isSignIn ? showForgotPasswordButton() : Container()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
