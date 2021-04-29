import 'package:flutter/material.dart';

import 'package:thirty/services/cloudFirestore.dart';
import 'package:thirty/services/routeNavigation.dart';
import 'package:thirty/standards/interfaceStandards.dart';
import 'package:thirty/standards/themes.dart';
import 'package:thirty/standards/paintStandards.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //CLASS INITIALIZATION
  CloudFirestore cloudFirestore = new CloudFirestore();
  RouteNavigation routeNavigation = new RouteNavigation();
  InterfaceStandards interfaceStandards = new InterfaceStandards();
  Themes themes = new Themes();
  PaintStandards paintStandards = new PaintStandards();
  BNBCustomPainter bnbCustomPainter = new BNBCustomPainter();

  //VARIALBE INITILIZATION
  String name;

  //INITIAL STATE
  //DESCRIPTION: Calls cloudFirestore function to set 'name' value
  void initState() {
    super.initState();
    cloudFirestore.getNameData().then((_name) => name = _name);
  }

  //USER INTERFACE: Show navigation bar floating action button
  //DESCRIPTION: Shows icon and loads camera function on tap
  //OUTPUT: Navigation bar floating action button with gesture detector function
  Widget showNavigationBarFloatingActionButton() {
    return new Center(
      heightFactor: 0.6,
      child: FloatingActionButton(
          backgroundColor: Colors.orange,
          child: Icon(Icons.shopping_basket),
          onPressed: () {}),
    );
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
            icon: Icon(
              Icons.home,
              color: currentIndex == 0 ? Colors.orange : Colors.grey.shade400,
            ),
            onPressed: () {
              setBottomBarIndex(0);
            },
            splashColor: Colors.white,
          ),
          IconButton(
              icon: Icon(
                Icons.restaurant_menu,
                color: currentIndex == 1 ? Colors.orange : Colors.grey.shade400,
              ),
              onPressed: () {
                setBottomBarIndex(1);
              }),
          Container(
            width: size.width * 0.20,
          ),
          IconButton(
              icon: Icon(
                Icons.bookmark,
                color: currentIndex == 2 ? Colors.orange : Colors.grey.shade400,
              ),
              onPressed: () {
                setBottomBarIndex(2);
              }),
          IconButton(
              icon: Icon(
                Icons.notifications,
                color: currentIndex == 3 ? Colors.orange : Colors.grey.shade400,
              ),
              onPressed: () {
                setBottomBarIndex(3);
              }),
        ],
      ),
    );
  }

  //Need to just throw this in the onTap => setState((index) => currentIndex = index)
  int currentIndex = 0;

  setBottomBarIndex(index) {
    setState(() {
      currentIndex = index;
    });
  }

  //USER INTERFACE: Home screen
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: themes.getDimension(context, true, "homeContainerDimension"),
        child: Stack(
          children: [
            Positioned(
              top: themes.getPosition(context, true, "homeHelloTitlePosition"),
              left:
                  themes.getPosition(context, false, "homeHelloTitlePosition"),
              child: interfaceStandards.showHelloTitle(
                  context, "helloTitle", name),
            ),
            Positioned(
              top: 300,
              child: interfaceStandards.parentCenter(
                  context, interfaceStandards.showImagePicker(context)),
            ),
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
                    paintStandards.homeNavigationBarPaint(context),
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
