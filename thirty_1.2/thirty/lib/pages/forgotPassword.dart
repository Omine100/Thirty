import 'package:flutter/material.dart';

import 'package:thirty/services/routeNavigation.dart';
import 'package:thirty/services/cloudFirestore.dart';
import 'package:thirty/standards/languageStandards.dart';
import 'package:thirty/standards/themes.dart';
import 'package:thirty/standards/gradientStandards.dart';
import 'package:thirty/standards/interfaceStandards.dart';

class ForgotPasswordScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  //Class initialization
  RouteNavigation routeNavigation = new RouteNavigation();
  CloudFirestore cloudFirestore = new CloudFirestore();
  Themes themes = new Themes();
  GradientStandards gradientStandards = new GradientStandards();
  InterfaceStandards interfaceStandards = new InterfaceStandards();

  //Variable initialization
  final _formKey = GlobalKey<FormState>();
  String _email;

  //User interface: Forgot password screen
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Container(
        height: themes.getDimension(
            context, true, "forgotPasswordContainerDimension"),
        decoration: BoxDecoration(
          gradient: gradientStandards.bodyLinearGradient(
              context,
              themes.getColor(context, "backgroundGradientTopRightColor"),
              themes.getColor(context, "backgroundGradientBottomLeftColor"),
              false),
        ),
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
              child:
                  interfaceStandards.showTitle(context, "forgotPasswordTitle"),
            ),
            Positioned(
              top: themes.getPosition(
                  context, true, "forgotPasswordInputPosition"),
              left: themes.getPosition(
                  context, false, "forgotPasswordInputPosition"),
              right: themes.getPosition(
                  context, false, "forgotPasswordInputPosition"),
              child: Form(
                  key: _formKey,
                  child: interfaceStandards.parentCenter(
                    context,
                    interfaceStandards.showTextField(context, 0, true,
                        "inputEmail", (value) => _email = value),
                  )),
            ),
            Positioned(
              top: themes.getPosition(
                  context, true, "forgotPasswordSendButtonPosition"),
              child: interfaceStandards.parentCenter(
                context,
                GestureDetector(
                  onTap: () {
                    cloudFirestore.sendPasswordReset(_email);
                    routeNavigation.RoutePop(context);
                  },
                  child: Text(
                    getTranslated(context, "forgotPasswordReset"),
                    style: TextStyle(
                      color:
                          themes.getColor(context, "forgotPasswordResetColor"),
                      fontSize: Theme.of(context)
                          .textTheme
                          .forgotPasswordResetFontSize,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
