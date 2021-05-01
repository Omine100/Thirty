import 'package:flutter/material.dart';

import 'package:thirty/services/cloudFirestore.dart';
import 'package:thirty/services/routeNavigation.dart';
import 'package:thirty/services/mediaManagement.dart';
import 'package:thirty/standards/interfaceStandards.dart';
import 'package:thirty/standards/themes.dart';
import 'package:thirty/standards/paintStandards.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key});

  //VARIABLE REFERENCE
  // final String name;

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //CLASS INITIALIZATION
  CloudFirestore cloudFirestore = new CloudFirestore();
  RouteNavigation routeNavigation = new RouteNavigation();
  MediaManagement mediaManagement = new MediaManagement();
  InterfaceStandards interfaceStandards = new InterfaceStandards();
  Themes themes = new Themes();
  Paints paints = new Paints();

  //VARIALBE INITILIZATION
  String name;
  int currentIndex;

  //INITIAL STATE
  //DESCRIPTION: Calls cloudFirestore function to set 'name' value
  void initState() {
    super.initState();
    cloudFirestore.getNameData().then((_name) => name = _name);
  }

  //MECHANICS: Sets current index
  //DESCRIPTION: Basically, this sets a new state so we can change the color of
  //          the active icon in the navigation bar
  //OUTPUT: Change of state to set new currentIndex value
  setCurrentIndex(index) {
    setState(() {
      currentIndex = index;
    });
  }

  //USER INTERFACE: Show navigation bar floating action button
  //DESCRIPTION: Shows icon and loads camera function on tap
  //OUTPUT: Navigation bar floating action button with gesture detector function
  Widget showNavigationBarFloatingActionButton() {
    return new Center(
        heightFactor: 0.55,
        child: Container(
          height: themes.getDimension(
              context, true, "homeNavigationBarFloatingActionButtonDimension"),
          width: themes.getDimension(
              context, true, "homeNavigationBarFloatingActionButtonDimension"),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(360),
            color: themes.getColor(
                context, "homeNavigationBarFloatingActionButtonColor"),
          ),
          child: GestureDetector(
            onTap: () {
              mediaManagement.callCamera();
            },
            child: Icon(
              Icons.camera_alt_rounded,
              color: themes.getColor(
                  context, "homeNavigationBarFloatingActionButtonIconColor"),
              size: themes.getDimension(context, true,
                  "homeNavigationBarFloatingActionButtonIconDimension"),
            ),
          ),
        ));
  }

  //USER INTERFACE: Show navigation bar icons
  //DESCRIPTION: Shows icons and provides functions based on what they do
  //OUTPUT: Navigation bar icons with gesture detector functions
  Widget showNavigationBarIcons() {
    return new Container(
      height: themes.getDimension(context, true, "homeNavigationBarDimension"),
      width: themes.getDimension(context, false, "homeNavigationBarDimension"),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
              padding: EdgeInsets.only(top: 10),
              icon: Icon(
                Icons.photo_album_rounded,
                color: currentIndex == 0
                    ? themes.getColor(context,
                        "homeNavigationBarSecondaryButtonIconActiveColor")
                    : themes.getColor(context,
                        "homeNavigationBarSecondaryButtonIconDeactiveColor"),
                size: themes.getDimension(
                    context, true, "homeNavigationBarIconDimension"),
              ),
              onPressed: () {
                setCurrentIndex(0);
              }),
          IconButton(
              icon: Icon(
                Icons.menu,
                color: currentIndex == 1
                    ? themes.getColor(context,
                        "homeNavigationBarSecondaryButtonIconActiveColor")
                    : themes.getColor(context,
                        "homeNavigationBarSecondaryButtonIconDeactiveColor"),
                size: themes.getDimension(
                    context, true, "homeNavigationBarIconDimension"),
              ),
              onPressed: () {
                setCurrentIndex(1);
              }),
          Container(
            width: themes.getDimension(
                context, false, "homeNavigationBarContainerDimension"),
          ),
          IconButton(
              icon: Icon(
                Icons.bookmark,
                color: currentIndex == 2
                    ? themes.getColor(context,
                        "homeNavigationBarSecondaryButtonIconActiveColor")
                    : themes.getColor(context,
                        "homeNavigationBarSecondaryButtonIconDeactiveColor"),
                size: themes.getDimension(
                    context, true, "homeNavigationBarIconDimension"),
              ),
              onPressed: () {
                setCurrentIndex(2);
              }),
          IconButton(
              padding: EdgeInsets.only(top: 10),
              icon: Icon(
                Icons.settings,
                color: currentIndex == 3
                    ? themes.getColor(context,
                        "homeNavigationBarSecondaryButtonIconActiveColor")
                    : themes.getColor(context,
                        "homeNavigationBarSecondaryButtonIconDeactiveColor"),
                size: themes.getDimension(
                    context, true, "homeNavigationBarIconDimension"),
              ),
              onPressed: () {
                setCurrentIndex(3);
              }),
        ],
      ),
    );
  }

  //USER INTERFACE: Home screen
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: themes.getColor(context, "homeBackgroundColor"),
        height: themes.getDimension(context, true, "homeContainerDimension"),
        child: Stack(
          children: [
            Positioned(
              top: themes.getPosition(context, true, "homeHelloTitlePosition"),
              left:
                  themes.getPosition(context, false, "homeHelloTitlePosition"),
              child: interfaceStandards.showHelloTitle(
                  context, "helloTitle", name.toString()),
            ),
            Positioned(
              top: 100,
              child: interfaceStandards.parentCenter(
                  context, interfaceStandards.showThemeSelector(context)),
            ),
            Positioned(
                top: 300,
                child: GestureDetector(
                  onTap: () {
                    cloudFirestore.signOut().then((test) {
                      routeNavigation.routeSignOutWelcome(context);
                    });
                  },
                  child: Container(
                    height: 50,
                    width: 50,
                    color: Colors.blue,
                  ),
                )),
            Positioned(
              bottom: themes.getPosition(
                  context, true, "homeNavigationBarPosition"),
              left: themes.getPosition(
                  context, true, "homeNavigationBarPosition"),
              child: Container(
                height: themes.getDimension(
                    context, true, "homeNavigationBarDimension"),
                width: themes.getDimension(
                    context, false, "homeNavigationBarDimension"),
                child: Stack(
                  children: [
                    paints.homeNavigationBarPaint(context),
                    showNavigationBarFloatingActionButton(),
                    showNavigationBarIcons(),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
