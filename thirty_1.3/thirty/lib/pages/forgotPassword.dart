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
            ],
          )),
    );
  }
}
