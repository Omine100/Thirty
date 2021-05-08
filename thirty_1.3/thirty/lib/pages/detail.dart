import 'package:flutter/material.dart';

import 'package:thirty/services/routeNavigation.dart';
import 'package:thirty/standards/themes.dart';

class DetailScreen extends StatefulWidget {
  DetailScreen({this.imageURL});

  //Variable reference
  final String imageURL;

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  //CLASS INITIALIZATION
  RouteNavigation routeNavigation = new RouteNavigation();
  Themes themes = new Themes();

  //VARIABLE INITIALIZATION
  String imageURL;

  //INITIAL STATE
  //DESCRIPTION: Sets imageURL to the widget imageURL value
  void initState() {
    super.initState();
    imageURL = widget.imageURL;
  }

  //USER INTERFACE: Detail screen
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Scaffold(
        backgroundColor: themes.getColor(context, "detailBackgroundColor"),
        body: Center(
          child: Hero(
            tag: 'imageCard$imageURL',
            child: Image.network(widget.imageURL)),
        ),
      ),
      onTap: () {
        routeNavigation.routePop(context);
      },
    );
  }
}