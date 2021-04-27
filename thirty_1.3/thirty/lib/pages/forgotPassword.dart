import 'package:flutter/material.dart';

import 'package:thirty/services/routeNavigation.dart';
import 'package:thirty/services/cloudFirestore.dart';
import 'package:thirty/standards/languageStandards.dart';
import 'package:thirty/standards/themes.dart';
import 'package:thirty/standards/gradientStandards.dart';
import 'package:thirty/standards/interfaceStandards.dart';

class ForgotPasswordScreen extends StatefulWidget {
  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  //CLASS INITIALIZATION
  RouteNavigation routeNavigation = new RouteNavigation();
  CloudFirestore cloudFirestore = new CloudFirestore();
  Themes themes = new Themes();
  GradientStandards gradientStandards = new GradientStandards();
  Gradients gradients = new Gradients();
  InterfaceStandards interfaceStandards = new InterfaceStandards();

  //VARIABLE INITIALIZATION
  final formKey = GlobalKey<FormState>();
  String email;

  //USER INTERFACE: Show reset password button
  //DESCRIPTION: When the user presses this button, it will send an email to the
  //          specified 'email' value and then return the user to the login screen
  //OUTPUT: Sends email and returns the user to the login screen
  Widget showResetPasswordButton() {
    return interfaceStandards.parentCenter(
        context,
        GestureDetector(
          onTap: () {
            cloudFirestore.sendPasswordReset(email);
            routeNavigation.routePop(context);
          },
          child: Text(
            getTranslated(context, "forgotPasswordReset"),
            style: TextStyle(
                color: themes.getColor(context, "forgotPasswordResetColor"),
                fontSize:
                    Theme.of(context).textTheme.forgotPasswordResetFontSize),
          ),
        ));
  }

  //USER INTERFACE: Forgot password screen
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Container(
          height: themes.getDimension(
              context, true, "forgotPasswordContainerDimension"),
          decoration: BoxDecoration(
              gradient: gradients.forgotPasswordScreenGradient(context)),
          child: Stack(
            children: [
              Positioned(
                top: themes.getPosition(
                    context, true, "forgotPasswordBackButtonPosition"),
                left: themes.getPosition(
                    context, false, "forgotPasswordBackButtonPosition"),
                child: interfaceStandards.backButton(context),
              ),
              Positioned(
                top: themes.getPosition(
                    context, true, "forgotPasswordTitlePosition"),
                child: interfaceStandards.showTitle(
                    context, "forgotPasswordTitle"),
              ),
              Positioned(
                top: themes.getPosition(
                    context, true, "forgotPasswordInputPosition"),
                left: themes.getPosition(
                    context, false, "forgotPasswordInputPosition"),
                child: Form(
                    key: formKey,
                    child: interfaceStandards.parentCenter(
                      context,
                      interfaceStandards.showTextField(context, 0, true,
                          "inputEmail", (value) => email = value, null),
                    )),
              ),
              Positioned(
                top: themes.getPosition(
                    context, true, "forgotPasswordSendButtonPosition"),
                child: showResetPasswordButton(),
              ),
            ],
          )),
    );
  }
}
