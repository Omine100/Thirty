import 'package:flutter/material.dart';
import 'package:thirty/pages/forgotPassword.dart';

import 'package:thirty/services/appLocalizations.dart';
import 'package:thirty/services/cloudFirestore.dart';
import 'package:thirty/standards/themes.dart';
import 'package:thirty/standards/themesGradients.dart';
import 'package:thirty/standards/interfaceStandards.dart';
import 'package:thirty/pages/intro.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({this.isSignIn});

  //Variable reference
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
  bool _isLoading, _isVisible = false, _isSignIn;

  //Mechanics: Initial state
  void initState() {
    super.initState();
    _isSignIn = widget.isSignIn;
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
      interfaceStandards.showProgress(context);
    });
    if (form.validate()) {
      form.save();
      try {
        if (isSignIn) {
          await cloudFirestore.signIn(_email, _password);
          setState(() {
            _isLoading = false;
          });
          Navigator.pop(context);
          Navigator.pushReplacementNamed(context, "/RootScreen");
        } else {
          await cloudFirestore.signUp(_email, _password);
          await cloudFirestore.createNameData(_name);
          cloudFirestore.sendEmailVerification();
          Navigator.pop(context);
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => IntroScreen(
                        slides: interfaceStandards.slideCreation(context),
                      )));
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
  Widget showInput(BuildContext context, String key) {
    return new TextFormField(
      keyboardType: key == AppLocalizations.of(context).translate("inputEmail")
          ? TextInputType.emailAddress
          : TextInputType.text,
      style: TextStyle(
        color: themes.getColor(context, "loginTextInputColor"),
        fontSize: Theme.of(context).textTheme.loginTextInputFontSize,
      ),
      decoration: InputDecoration(
        prefixIcon: Icon(
          key != AppLocalizations.of(context).translate("inputEmail")
              ? key == AppLocalizations.of(context).translate("inputPassword")
                  ? Icons.lock
                  : Icons.person
              : Icons.email,
          color: themes.getColor(context, "loginTextInputColor"),
        ),
        hintText: key,
        hintStyle: TextStyle(
          color: themes.getColor(context, "loginTextInputColor"),
        ),
        labelStyle: TextStyle(
          color: themes.getColor(context, "loginTextInputColor"),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: themes.getColor(context, "loginTextInputColor"),
          ),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: themes.getColor(context, "loginTextInputColor"),
          ),
        ),
      ),
      validator: (value) => value.isEmpty
          ? "$key " + AppLocalizations.of(context).translate("inputValidator")
          : null,
      onSaved: (value) =>
          key != AppLocalizations.of(context).translate("inputEmail")
              ? key == AppLocalizations.of(context).translate("inputPassword")
                  ? _password = value.trim()
                  : _name = value.trim()
              : _email = value.trim(),
      obscureText:
          key == AppLocalizations.of(context).translate("inputPassword")
              ? (_isVisible ? false : true)
              : false,
      maxLines: 1,
    );
  }

  //User interface: Show visible button
  Widget showVisiblityButton() {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isVisible = !_isVisible;
        });
      },
      child: Icon(
        _isVisible ? Icons.visibility : Icons.visibility_off,
        color: themes.getColor(context, "loginVisibilityButtonColor"),
      ),
    );
  }

  //User interface: Show alternative button
  Widget showAlternativeButton() {
    return new Text(
      _isSignIn
          ? AppLocalizations.of(context).translate("loginAlternativeSignUp")
          : AppLocalizations.of(context).translate("loginAlternativeSignIn"),
      style: TextStyle(
        color: themes.getColor(context, "loginAlternativeButtonTextColor"),
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
      AppLocalizations.of(context).translate("loginForgotPassword"),
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
    return Scaffold(
      body: Container(
          height: themes.getDimension(context, true, "loginContainerDimension"),
          decoration: BoxDecoration(
              gradient: themesGradients.bodyLinearGradient(
                  context,
                  themes.getColor(context, "backgroundGradientTopRightColor"),
                  themes.getColor(context, "backgroundGradientBottomLeftColor"),
                  false)),
          child: Stack(
            children: [
              Positioned(
                  top: themes.getPosition(context, true, "loginTitlePosition"),
                  child: interfaceStandards.parentCenter(
                      context,
                      _isSignIn
                          ? interfaceStandards.showTitle(
                              context, "loginSignInTitle")
                          : interfaceStandards.showTitle(
                              context, "loginSignUpTitle"))),
              SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      !_isSignIn
                          ? Padding(
                              padding: EdgeInsets.only(
                                  left: 50, right: 50, top: 175),
                              child: interfaceStandards.parentCenter(
                                  context,
                                  showInput(
                                      context,
                                      AppLocalizations.of(context)
                                          .translate('inputName'))),
                            )
                          : Container(),
                      Padding(
                        padding: EdgeInsets.only(
                            left: 50, right: 50, top: _isSignIn ? 175 : 35),
                        child: interfaceStandards.parentCenter(
                            context,
                            showInput(
                                context,
                                AppLocalizations.of(context)
                                    .translate('inputEmail'))),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 50, right: 50, top: 35),
                        child: interfaceStandards.parentCenter(
                            context,
                            showInput(
                                context,
                                AppLocalizations.of(context)
                                    .translate('inputPassword'))),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: themes.getPosition(
                    context, true, "loginProgressionButtonPosition"),
                child: interfaceStandards.parentCenter(
                    context,
                    GestureDetector(
                      onTap: () {
                        validateAndSubmit(_isSignIn);
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
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ForgotPasswordScreen()));
                  },
                  child: interfaceStandards.parentCenter(context,
                      _isSignIn ? showForgotPasswordButton() : Container()),
                ),
              ),
            ],
          )),
    );
  }
}
