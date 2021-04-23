import 'package:flutter/material.dart';

import 'package:thirty/services/routeNavigation.dart';
import 'package:thirty/services/cloudFirestore.dart';
import 'package:thirty/standards/languageStandards.dart';
import 'package:thirty/standards/themes.dart';
import 'package:thirty/standards/gradientStandards.dart';
import 'package:thirty/standards/interfaceStandards.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({this.isSignIn});

  //VARIABLE REFERENCES
  final bool isSignIn;

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  //CLASS INITIALIZATION
  RouteNavigation routeNavigation = new RouteNavigation();
  CloudFirestore cloudFirestore = new CloudFirestore();
  Themes themes = new Themes();
  GradientStandards gradientStandards = new GradientStandards();
  Gradients gradients = new Gradients();
  InterfaceStandards interfaceStandards = new InterfaceStandards();

  //VARIABLE INITIALIZATION
  final formKey = GlobalKey<FormState>();
  String name, email, password;
  bool isSignIn, isVisible = false;

  //INITIAL STATE
  //DESCRIPTION: Sets sign in boolean prior to the state loading
  void initState() {
    super.initState();
    isSignIn = widget.isSignIn;
  }

  //MECHANICS: Validate and submit user information
  //DESCRIPTION: Takes the key and gets the values currently associated with it
  //          from here we can validate these values and do stuff with them
  //OUTPUT: Route navigation to Intro or Home screen
  void validateAndSubmit() async {
    final form = formKey.currentState;
    setState(() {
      interfaceStandards.showProgress(context);
    });
    if (form.validate()) {
      form.save();
      try {
        if (!isSignIn) {
          await cloudFirestore.signUpEmailAndPassword(
              context, email, password, name);
          await cloudFirestore.signInEmailAndPassword(context, email, password);
        } else {
          await cloudFirestore.signInEmailAndPassword(context, email, password);
        }
        if (await cloudFirestore.getSignedInStatus() == true) {
          routeNavigation.routeHome(context);
        }
        form.reset();
      } catch (e) {
        print("Error: $e");
        setState(() {
          form.reset();
        });
      }
    }
  }

  //USER INTERFACE: Show visibility button
  //DESCRIPTION: Shows a widget and allows for gesture input to change the value
  //          of 'isVisible' to it's complement
  //OUTPUT: Widget and change of state to change 'isVisible' value
  IconButton showVisibilityButton() {
    return IconButton(
      icon: Icon(
        isVisible ? Icons.visibility : Icons.visibility_off,
        color: themes.getColor(context, "loginVisibilityButtonColor"),
      ),
      onPressed: () {
        setState(() {
          isVisible = !isVisible;
        });
      },
    );
  }

  //USER INTERFACE: Show alternative button
  //DESCRIPTION: If you accidentally go to the signIn or signUp page, then this
  //          allows for you to switch between the two without having to go back
  //          to the welcome.dart page. We can also just change the state here
  //          instead of having two separate pages for signIn and signUp
  //OUTPUT: Widget and state change
  Widget showAlternativeButton() {
    return interfaceStandards.parentCenter(
      context,
      GestureDetector(
        onTap: () {
          setState(() {
            isSignIn = !isSignIn;
          });
        },
        child: interfaceStandards.parentCenter(
          context,
          Text(
            isSignIn
                ? getTranslated(context, "loginAlternativeSignUp")
                : getTranslated(context, "loginAlternativeSignIn"),
            style: TextStyle(
              color: themes.getColor(context, "loginAlternativeTextColor"),
              fontSize: Theme.of(context)
                  .textTheme
                  .loginAlternativeButtonTextFontSize,
              fontWeight: Theme.of(context)
                  .typography
                  .loginAlternativeButtonTextFontWeight,
            ),
          ),
        ),
      ),
    );
  }

  //USER INTERFACE: Show forgot password button
  //DESCRIPTION: If the user has forgotten their password, they can be taken to
  //          a different page to input their email and get access to their
  //          account again. It also makes it to where if we are on the signUp
  //          page, we do not see this at all
  //OUTPUT: Widget and state change
  Widget showForgotPasswordButton() {
    return interfaceStandards.parentCenter(
      context,
      GestureDetector(
        onTap: () {
          // routeNavigation.RouteForgotPassword(context);
        },
        child: interfaceStandards.parentCenter(
            context,
            isSignIn
                ? Text(
                    getTranslated(context, "loginForgotPassword"),
                    style: TextStyle(
                      color: themes.getColor(
                          context, "loginForgotPasswordButtonTextColor"),
                      fontSize: Theme.of(context)
                          .textTheme
                          .loginForgotPasswordButtonTextFontSize,
                      fontWeight: Theme.of(context)
                          .typography
                          .loginForgotPasswordButtonTextFontWeight,
                    ),
                  )
                : Container()),
      ),
    );
  }

  //USER INTERFACE: Show progression button
  //DESCRIPTION: Whether you are on the signIn or signUp state of this page,
  //          pressing this button will send off you data to the
  //          validateAndSubmit() and do what it wants with it (nothing illegal
  //          of course)
  //OUTPUT: Widget and call to validateAndSubmit()
  Widget showProgressionButton() {
    return interfaceStandards.parentCenter(
      context,
      GestureDetector(
        onTap: () {
          validateAndSubmit();
        },
        child: Container(
          height: themes.getDimension(
              context, true, "loginProgressionButtonDimension"),
          width: themes.getDimension(
              context, true, "loginProgressionButtonDimension"),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(360.0),
            color: themes.getColor(context, "loginProgressionButtonColor"),
          ),
          child: Icon(
            Icons.arrow_forward_ios,
            color: themes.getColor(context, "loginProgressionButtonIconColor"),
          ),
        ),
      ),
    );
  }

  //USER INTERFACE: Login screen
  @override
  Widget build(BuildContext context) {
    //VARIABLE INITIALIZATION
    final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

    //USER INTERFACE: Login screen
    return new Scaffold(
      key: scaffoldKey,
      body: Container(
        height: themes.getDimension(context, true, "loginContainerDimension"),
        decoration:
            BoxDecoration(gradient: gradients.loginScreenGradient(context)),
        child: Stack(
          children: [
            Positioned(
              top: themes.getPosition(context, true, "loginTitlePosition"),
              child: isSignIn
                  ? interfaceStandards.showTitle(context, "loginSignInTitle")
                  : interfaceStandards.showTitle(context, "loginSignUpTitle"),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    !isSignIn
                        ? Padding(
                            padding:
                                EdgeInsets.only(left: 50, right: 50, top: 175),
                            child: interfaceStandards.parentCenter(
                              context,
                              interfaceStandards.showTextField(context, 1, true,
                                  "inputName", (value) => name = value, null),
                            ))
                        : Container(),
                    Padding(
                      padding: EdgeInsets.only(
                          left: 50, right: 50, top: isSignIn ? 175 : 35),
                      child: interfaceStandards.parentCenter(
                          context,
                          interfaceStandards.showTextField(context, 1, true,
                              "inputEmail", (value) => email = value, null)),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 50, right: 50, top: 35),
                      child: interfaceStandards.parentCenter(
                          context,
                          interfaceStandards.showTextField(
                              context,
                              1,
                              isVisible,
                              "inputPassword",
                              (value) => password = value,
                              showVisibilityButton())),
                    )
                  ],
                ),
              ),
            ),
            Positioned(
              top: themes.getPosition(
                  context, true, "loginProgressionButtonPosition"),
              child: showProgressionButton(),
            ),
            Positioned(
              top: themes.getPosition(
                  context, true, "loginAlternativeButtonPosition"),
              child: showAlternativeButton(),
            ),
            Positioned(
              top: themes.getPosition(
                  context, true, "loginForgotPasswordButtonPosition"),
              left: themes.getPosition(
                  context, false, "loginForgotPasswordButtonPosition"),
              child: showForgotPasswordButton(),
            ),
          ],
        ),
      ),
    );
  }
}
