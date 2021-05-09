import 'package:flutter/material.dart';
import 'package:scroll_snap_list/scroll_snap_list.dart';
import 'dart:math';

import 'package:thirty/services/cloudFirestore.dart';
import 'package:thirty/services/routeNavigation.dart';
import 'package:thirty/services/mediaManagement.dart';
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
  MediaManagement mediaManagement = new MediaManagement();
  InterfaceStandards interfaceStandards = new InterfaceStandards();
  Themes themes = new Themes();
  Paints paints = new Paints();

  //VARIALBE INITILIZATION
  String name;
  int currentIndex, focusedIndex = 0;

  //INITIAL STATE
  //DESCRIPTION: Calls cloudFirestore function to set 'name' value
  void initState() {
    super.initState();
    cloudFirestore.getNameData().then((_name) => {
          setState(() {
            name = _name;
          })
        });
  }

  //MECHANICS: Sets current index
  //DESCRIPTION: Basically, this sets a new state so we can change the color of
  //          the active icon in the navigation bar
  //OUTPUT: Change of state to set new currentIndex value
  //NOTE: 'currentIndex' used to index the navigationBar icon selection
  setCurrentIndex(index) {
    setState(() {
      currentIndex = index;
    });
  }

  //MECHANICS: Sets the new state for the item in focus
  //OUTPUT: Change of state to set new focusedIndex value
  //NOTE: 'focusedIndex' used to index the current item being shown in the scroll
  onItemFocus(int index) {
    setState(() {
      focusedIndex = index;
    });
  }

  //MECHANICS: Returns equation for items in the home page's scroll
  //DESCRIPTION: This allows for you to change the distance between each card
  //          which can be altered by changing the point at the end
  //OUTPUT: Double equation
  double customEquation(double distance) {
    return 1 - min(distance.abs() / 500, 0.3);
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
              interfaceStandards.showMediaSelectionDialog(context, this);
              setState(() {});
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
                Icons.photo_album_outlined,
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
                Icons.menu_outlined,
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
                Icons.bookmark_border_outlined,
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
                Icons.person_outline,
                color: currentIndex == 3
                    ? themes.getColor(context,
                        "homeNavigationBarSecondaryButtonIconActiveColor")
                    : themes.getColor(context,
                        "homeNavigationBarSecondaryButtonIconDeactiveColor"),
                size: themes.getDimension(
                    context, true, "homeNavigationBarIconDimension"),
              ),
              onPressed: () {
                routeNavigation.routeSettings(context);
                setCurrentIndex(3);
              }),
        ],
      ),
    );
  }

  //USER INTERFACE: Show image list
  //DESCRIPTION: Takes in a list of images and displays each one in the a card
  //          format for the user to see and interact with - when they tap on the
  //          image, it should display it in fullscreen. If the date for the image
  //          is in a new month, then we have a card saying the next month (ex:
  //          "March" - maybe displayed sideways)
  //OUTPUT: Cards with images and text for new month
  Widget showImageList() {
    return Container(
      height:
          themes.getDimension(context, true, "homeImageListContainerDimension"),
      width: themes.getDimension(
          context, false, "homeImageListContainerDimension"),
      child: FutureBuilder(
        future: cloudFirestore.getImageURLStreamData(),
        builder: (BuildContext context, snapshot) {
          List<String> imageURLStream = snapshot.data ?? [];
          if (snapshot.hasData) {
            interfaceStandards.showProgress(context);
          } else {
            //Container with camera later on
            return Container(
              width: themes.getDimension(
                  context, false, "homeImageListCardDimension"),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20), color: Colors.grey),
            );
          }
          return ScrollSnapList(
            onItemFocus: onItemFocus,
            scrollDirection: Axis.horizontal,
            itemSize: themes.getDimension(
                context, false, "homeImageListCardDimension"),
            focusOnItemTap: true,
            reverse: true,
            dynamicItemSize: true,
            dynamicItemOpacity: 0.75,
            dynamicSizeEquation: customEquation,
            itemCount: imageURLStream.length,
            itemBuilder: (context, int index) {
              String imageURL = imageURLStream[index];
              return showImageCard(imageURL);
            },
          );
        },
      ),
    );
  }

  //USER INTERFACE: Show month card
  //DESCRIPTION: Takes in the month and year and creates a card for it
  //OUTPUT: Card with a month and year (sideways)
  Widget showMonthCard(String month, String year) {
    return null;
  }

  //USER INTERFACE: Show image card
  //DESCRIPTION: Takes in the information for one image from the list and creates
  //          a card for it to display the information. When you tap on it, it
  //          should display full screen, long press should delete it
  //STRING INPUT: 'imageURL' for having something to reference
  //OUTPUT: Card with image
  Widget showImageCard(String imageURL) {
    return GestureDetector(
      onTap: () {
        routeNavigation.routeDetail(context, imageURL);
      },
      child: Hero(
        tag: 'imageCard$imageURL',
        child: Container(
          width:
              themes.getDimension(context, false, "homeImageListCardDimension"),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(60),
            child: cloudFirestore.getImageData(imageURL),
          ),
        ),
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
              top: 120,
              left: 22,
              child: Text(
                "Sunday, May 2021",
                style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 25,
                    fontWeight: FontWeight.w300),
              ),
            ),
            Positioned(
              top: themes.getPosition(context, true, "homeImageListPosition"),
              child: showImageList(),
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
