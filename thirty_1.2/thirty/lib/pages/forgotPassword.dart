import 'package:flutter/material.dart';

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
  CloudFirestore cloudFirestore = new CloudFirestore();
  Themes themes = new Themes();
  GradientStandards gradientStandards = new GradientStandards();
  InterfaceStandards interfaceStandards = new InterfaceStandards();

  //Variable initialization
  final _formKey = GlobalKey<FormState>();
  String _email;
  final inputController = TextEditingController();

  //User interface: Show email input
  Widget showEmailInput() {
    return new TextFormField(
      controller: inputController,
    );
  }
}
