import 'package:flutter/material.dart';

import 'package:thirty/services/cloudFirestore.dart';
import 'package:thirty/standards/themes.dart';
import 'package:thirty/standards/themesGradients.dart';
import 'package:thirty/standards/interfaceStandards.dart';

class ForgotPasswordScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  //Class initialization
  CloudFirestore cloudFirestore = new CloudFirestore();
  Themes themes = new Themes();
  ThemesGradients themesGradients = new ThemesGradients();
  InterfaceStandards interfaceStandards = new InterfaceStandards();

  //Variable initialization
  final _formKey = GlobalKey<FormState>();
  String _email;

  //User interface: Show email input
  Widget showEmailInput() {
    return new TextFormField(
      keyboardType: TextInputType.emailAddress,
      style: TextStyle(
        color: Theme.of(context).colorScheme.forgotPasswordTextInputColor,
        fontSize: Theme.of(context).textTheme.forgotPasswordTextInputFontSize,
      ),
      decoration: InputDecoration(
        prefixIcon: Icon(
          Icons.email,
          color: Theme.of(context).colorScheme.forgotPasswordTextInputColor,
        ),
        hintText: "Email",
        hintStyle: TextStyle(
          color: Theme.of(context).colorScheme.forgotPasswordTextInputColor,
        ),
        labelStyle: TextStyle(
          color: Theme.of(context).colorScheme.forgotPasswordTextInputColor,
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.forgotPasswordTextInputColor,
          ),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.forgotPasswordTextInputColor,
          ),
        ),
      ),
      validator: (value) => value.isEmpty ? "Email can\'t be empty" : null,
      onSaved: (value) => _email = value.trim(),
      obscureText: false,
      maxLines: 1,
    );
  }

  //User interface: Forgot password screen
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Container(
        height: themes.getDimension(
            context, true, "forgotPasswordContainerDimension"),
        decoration: BoxDecoration(
          gradient: themesGradients.bodyLinearGradient(
              context,
              Theme.of(context).colorScheme.backgroundGradientTopLeftColor,
              Theme.of(context).colorScheme.backgroundGradientBottomRightColor,
              false),
        ),
        child: Stack(
          children: <Widget>[
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
              left: themes.getPosition(
                  context, false, "forgotPasswordTitlePosition"),
              child: Text(
                "Forgot Password",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.forgotPasswordTitleColor,
                  fontSize:
                      Theme.of(context).textTheme.forgotPaswordTitleFontSize,
                  fontWeight: Theme.of(context)
                      .typography
                      .forgotPasswordTitleFontWeight,
                ),
              ),
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
                    showEmailInput(),
                  )),
            ),
            Positioned(
              top: themes.getPosition(
                  context, true, "forgotPasswordSendButtonPosition"),
              child: Container(
                width: themes.getDimension(
                    context, false, "forgotPasswordSendButtonDimension"),
                child: Center(
                  child: GestureDetector(
                    onTap: () {
                      cloudFirestore.sendPasswordReset(_email);
                      Navigator.pop(context);
                    },
                    child: Text(
                      "Reset Password",
                      style: TextStyle(
                        color: Theme.of(context)
                            .colorScheme
                            .forgotPasswordResetColor,
                        fontSize: Theme.of(context)
                            .textTheme
                            .forgotPasswordResetFontSize,
                      ),
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
