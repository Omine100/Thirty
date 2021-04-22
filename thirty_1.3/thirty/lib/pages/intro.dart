import 'package:flutter/material.dart';

class IntroScreen extends StatefulWidget {
  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  //USER INTERFACE: Intro screen
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Text(
          "Intro",
          style: TextStyle(
            color: Colors.red,
            fontSize: 100,
          ),
        ),
      ),
    );
  }
}
