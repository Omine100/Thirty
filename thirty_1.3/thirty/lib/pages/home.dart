import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //USER INTERFACE: Home screen
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Text(
          "Home",
          style: TextStyle(
            color: Colors.red,
            fontSize: 100,
          ),
        ),
      ),
    );
  }
}
