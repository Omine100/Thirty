import 'package:flutter/material.dart';
import 'package:scroll_snap_list/scroll_snap_list.dart';

import 'package:thirty/services/cloudFirestore.dart';
import 'package:thirty/services/routeNavigation.dart';
import 'package:thirty/services/mediaManagement.dart';
import 'package:thirty/standards/interfaceStandards.dart';
import 'package:thirty/standards/themes.dart';
import 'package:thirty/standards/methodStandards.dart';
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
  MethodStandards methodStandards = new MethodStandards();
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
              mediaManagement.getImage(true, this);
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
            return Container();
          }
          return ScrollSnapList(
            onItemFocus: onItemFocus,
            scrollDirection: Axis.horizontal,
            itemSize: 275,
            focusOnItemTap: true,
            reverse: true,
            dynamicItemSize: true,
            dynamicItemOpacity: 0.75,
            dynamicSizeEquation: methodStandards.getScale(),
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
          width: 275,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.grey,
          ),
          child: cloudFirestore.getImageData(imageURL),
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
                top: themes.getPosition(
                    context, true, "homeThemeSelectorButtonPosition"),
                right: themes.getPosition(
                    context, false, "homeThemeSelectorButtonPosition"),
                child: interfaceStandards.parentCenter(
                    context, interfaceStandards.showThemeSelector(context))),
            Positioned(
              top: themes.getPosition(context, true, "homeImageListPosition"),
              child: showImageList(),
            ),
            Positioned(
                top: themes.getPosition(
                    context, true, "homeSignOutButtonPosition"),
                right: themes.getPosition(
                    context, false, "homeSignOutButtonPosition"),
                child: GestureDetector(
                  onTap: () {
                    cloudFirestore.signOut().then((test) {
                      routeNavigation.routeSignOutWelcome(context);
                    });
                  },
                  child: interfaceStandards.parentCenter(
                    context,
                    Icon(
                      Icons.exit_to_app_rounded,
                      size: themes.getDimension(context, true, "homeSignOutButtonDimension"),
                      color: themes.getColor(context, "homeSignOutButtonColor")
                    ),
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
