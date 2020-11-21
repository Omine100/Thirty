import 'package:flutter/material.dart';

import 'package:thirty/services/cloudFirestore.dart';
import 'package:thirty/services/root.dart';
import 'package:thirty/standards/themes.dart';
import 'package:thirty/standards/themesGradients.dart';
import 'package:thirty/standards/interfaceStandards.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({this.signInCallback, this.isSignIn});

  //Variable reference
  final VoidCallback signInCallback;
  final bool isSignIn;

  @override
  State<StatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  //Class initialization
  CloudFirestore cloudFirestore = new CloudFirestore();
  Themes themes = new Themes();
  ThemesGradients themesGradients = new ThemesGradients();
  InterfaceStandards interfaceStandards = new InterfaceStandards();

  //Variable initialization
  final _formKey = GlobalKey<FormState>();
  String _name, _email, _password, _errorMessage;
  bool _isLoading, _isVisible = false;

  //Mechanics: Reset the form
  void resetForm() {
    setState(() {
      _formKey.currentState.reset();
      _errorMessage = "";
    });
  }

  //Mechanics: Validate and submit user information
  void validateAndSubmit(bool isSignIn) async {
    final form = _formKey.currentState;
    setState(() {
      _errorMessage = "";
      _isLoading = true;
    });
    if (form.validate()) {
      form.save();
      try {
        if (isSignIn) {
          await cloudFirestore.signIn(_email, _password);
          setState(() {
            _isLoading = false;
          });
          widget.signInCallback();
        } else {
          await cloudFirestore.signUp(_email, _password);
          await cloudFirestore.createNameData(_name);
          cloudFirestore.sendEmailVerification();
          validateAndSubmit(true);
        }
      } catch (e) {
        print("Error: $e");
        setState(() {
          _isLoading = false;
          _errorMessage = e.message;
          resetForm();
        });
      }
    } else {
      setState(() {
        _errorMessage = "";
        _isLoading = false;
      });
    }
  }

  //User interface: Show sign in or sign up input fields
  Widget showInput(BuildContext context, String text) {
    return new TextFormField(
      keyboardType:
          text == "Email" ? TextInputType.emailAddress : TextInputType.text,
      style: TextStyle(
        color: Theme.of(context).colorScheme.loginTextInputColor,
        fontSize: Theme.of(context).textTheme.loginTextInputFontSize,
      ),
      decoration: InputDecoration(
        prefixIcon: Icon(
          text != "Email"
              ? text == "Password" ? Icons.lock : Icons.person
              : Icons.email,
          color: Theme.of(context).colorScheme.loginTextInputColor,
        ),
        hintText: text,
        hintStyle: TextStyle(
          color: Theme.of(context).colorScheme.loginTextInputColor,
        ),
        labelStyle: TextStyle(
          color: Theme.of(context).colorScheme.loginTextInputColor,
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.loginTextInputColor,
          ),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.loginTextInputColor,
          ),
        ),
      ),
      validator: (value) => value.isEmpty ? "$text can\'t be empty" : null,
      onSaved: (value) => text != "Email"
          ? text == "Password" ? _password = value.trim() : _name = value.trim()
          : _email = value.trim(),
      obscureText: text == "Password" ? (_isVisible ? false : true) : false,
      maxLines: 1,
    );
  }

  //User interface: Show visible button
  Widget showVisibleButton() {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isVisible = !_isVisible;
        });
      },
      child: Icon(
        _isVisible ? Icons.visibility : Icons.visibility_off,
        color: Theme.of(context).colorScheme.loginTitleColor,
      ),
    );
  }

  //User interface: Show forgot password button
  Widget showForgotPasswordButton() {
    return new Text(
      "Forgot Password?",
      style: TextStyle(
        color: Theme.of(context).colorScheme.loginForgotPasswordButtonTextColor,
        fontSize:
            Theme.of(context).textTheme.loginForgotPasswordButtonTextFontSize,
        fontWeight: Theme.of(context)
            .typography
            .loginForgotPasswordButtonTextFontWeight,
      ),
    );
  }

  //User interface: Login screen
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.loginErrorMessageColor,
      body: Container(
          height: themes.getDimension(context, true, "loginContainerDimension"),
          child: widget.isSignIn // Remove this and make the name thing optional
              ? Stack(
                  children: [
                    Positioned(
                      top: 500,
                      child: Text("Testing"),
                    ),
                    Positioned(
                        top: 100,
                        left: 50,
                        right: 50,
                        child: interfaceStandards.parentCenter(
                            context, showInput(context, "Email"))),
                    Positioned(
                      top: 250,
                      left: 50,
                      right: 50,
                      child: interfaceStandards.parentCenter(
                          context, showInput(context, "Password")),
                    ),
                  ],
                )
              : Stack()),
    );
  }
}
