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
}
