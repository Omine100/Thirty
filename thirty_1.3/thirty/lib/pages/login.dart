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
  InterfaceStandards interfaceStandards = new InterfaceStandards();

  //VARIABLE INITIALIZATION
  final _formKey = GlobalKey<FormState>();
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
  //GLOBALKEY<SCAFFOLDSTATE> INPUT: 'scaffold' for the globalKey associated with
  //          the scaffold below
  //OUTPUT: Route navigation to Intro or Home screen
  void validateAndSubmit() async {
    final form = _formKey.currentState;
    setState(() {
      interfaceStandards.showProgress(context);
    });
    if(form.validate()) {
      form.save();
      try {
        if (isSignIn) {
          await cloudFirestore.signInEmailAndPassword(email, password);
          routeNavigation.RouteHome(context);
        } else {
          await cloudFirestore.signUpEmailAndPassword(email, password);
          await cloudFirestore.createNameData(name);
          cloudFirestore.sendEmailVerification();
          routeNavigation.RouteIntro(context, email, password);
        }
      } catch (e) {
        print("Error: $e");
        setState(() {
                  form.reset();
                });
      }
    })
  }

  //USER INTERFACE: LOGIN SCREEN
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
