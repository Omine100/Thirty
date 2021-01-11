import 'package:flutter/material.dart';

void main() {
  runApp(new Thirty());
}

class Thirty extends StatefulWidget {
  @override
  _ThirtyState createState() => _ThirtyState();
}

class _ThirtyState extends State<Thirty> {
  //User interface: Thirty app
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Thirty",
      debugShowCheckedModeBanner: false,
      debugShowMaterialGrid: false,
      home: RouteNavigation(),
    );
  }
}