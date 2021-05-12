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

  //USER INTERFACE: Show share button
  //DESCRIPTION: Shows a button and then tap, takes the imageURL and allows for
  //          the user to share it
  //OUTPUT: Widget and share function
  Widget showShareButton() {
    return new GestureDetector(
      onTap: () {},
      child: Icon(
        Icons.share_outlined,
        size: themes.getDimension(
            context, true, "detailShareButtonIconDimension"),
        color: themes.getColor(context, "detailShareButtonIconColor"),
      ),
    );
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
              child: Stack(
                children: [
                  Image.network(widget.imageURL),
                  Positioned(
                    bottom: themes.getPosition(
                        context, true, "detailShareButtonPosition"),
                    child: Center(child: showShareButton()),
                  ),
                ],
              )),
        ),
      ),
      onTap: () {
        routeNavigation.routePop(context);
      },
    );
  }
}
