import 'package:flutter/material.dart';

import 'package:thirty/services/root.dart';
import 'package:thirty/services/cloudFirestore.dart';
import 'package:thirty/standards/themes.dart';
import 'package:thirty/standards/themesGradients.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({this.signInCallback});

  //Variable reference
  final VoidCallback signInCallback;

  @override
  State<StatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  //Class initialization
  CloudFirestore cloudFirestore = new CloudFirestore();
  Themes themes = new Themes();

  //Variable initialization
  final _formKey = GlobalKey<FormState>();
  String _name, _email, _password, _errorMessage;
  bool _isLoading, _isSignIn, _isVisible;

  //Initial state
  @override
  void initState() {
    super.initState();
    _errorMessage = "";
    _isSignIn = true;
    _isLoading = false;
    _isVisible = false;
  }

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

  //User interface: Show sign in or sign up button
  Widget showSignInSignUpButton(bool isSignIn, Shader linearGradient) {
    return new Container(
      height: themes.getDimension(
          context, true, "loginSignInSignUpButtonDimension"),
      width: themes.getDimension(
          context, false, "loginSignInSignUpButtonDimension"),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30.0),
        color: Theme.of(context).colorScheme.loginSignInSignUpButtonColor,
      ),
      child: Center(
        child: Text(
          isSignIn ? "LOGIN" : "SIGN UP",
          style: TextStyle(
            foreground: Paint()..shader = linearGradient,
            fontSize: Theme.of(context).textTheme.loginSignInSignUpButtonText,
            fontWeight:
                Theme.of(context).typography.loginSignInSignUpButtonFontWeight,
          ),
        ),
      ),
    );
  }

  //User interface: Show sign in or sign up alternate text
  Widget showSignInSignUpAlternateText(bool isSignIn) {
    return RichText(
      text: TextSpan(
        text:
            !isSignIn ? "Already have an account? " : "Don't have an account? ",
        style: TextStyle(
          color:
              Theme.of(context).colorScheme.loginSignInSignUpAlternateTextColor,
          fontSize: Theme.of(context)
              .textTheme
              .loginSignInSignUpAlternateTextFontSize,
        ),
        children: <TextSpan>[
          TextSpan(
            text: !isSignIn ? "Sign In" : "Sign Up",
            style: TextStyle(
              color: Theme.of(context)
                  .colorScheme
                  .loginSignInSignUpAlternateTextColor,
              fontSize: Theme.of(context)
                  .textTheme
                  .loginSignInSignUpAlternateTextFontSize,
              fontWeight: Theme.of(context)
                  .typography
                  .loginSignInSignUpAlternateTextFontWeight,
            ),
          ),
        ],
      ),
    );
  }

  //User interface: Show forgot password button
  Widget showForgotPasswordButton() {
    return new Text(
      "Forgot Password?",
      style: TextStyle(
        color: Theme.of(context).colorScheme.loginForgotPasswordButtonColor,
        fontSize: Theme.of(context).textTheme.loginForgotPasswordButtonFontSize,
        fontWeight:
            Theme.of(context).typography.loginForgotPasswordButtonFontWeight,
      ),
    );
  }
}
