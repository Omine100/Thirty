import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:scroll_snap_list/scroll_snap_list.dart';
import 'dart:math';

import 'package:thirty/services/cloudFirestore.dart';
import 'package:thirty/services/routeNavigation.dart';
import 'package:thirty/services/mediaManagement.dart';
import 'package:thirty/standards/interfaceStandards.dart';
import 'package:thirty/standards/themes.dart';
import 'package:thirty/standards/languageStandards.dart';
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
  int currentIndex = 0, focusedIndex = 0;
  List<DocumentSnapshot> documentSnapshots = [];

  //INITIAL STATE
  //DESCRIPTION: Calls cloudFirestore function to set 'name' value and documentSnapshot for images
  void initState() {
    super.initState();
    cloudFirestore.getNameData().then((_name) => {
          setState(() {
            name = _name;
          })
        });
    cloudFirestore
        .getImageDocuments()
        .then((_documentSnapshots) => {documentSnapshots = _documentSnapshots});
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
    return 1 - min(distance.abs() / 500, 0.25);
  }

  //USER INTERFACE: Show hello title
  //DESCRIPTION: Shows a title for the home page
  //OUTPUT: Text displayed in a general way for the application
  Widget showHelloTitle() {
    return Text(
      methodStandards.getCurrentTimeSegment() == 0
          ? getTranslated(context, "goodMorning")
          : (methodStandards.getCurrentTimeSegment() == 1
              ? getTranslated(context, "goodAfternoon")
              : getTranslated(context, "goodEvening")),
      style: TextStyle(
        color: themes.getColor(context, "homeHelloTitleTextColor"),
        fontSize: Theme.of(context).textTheme.homeHelloTitleFontSize,
        fontWeight: Theme.of(context).typography.homeHelloTitleFontWeight,
      ),
    );
  }

  //USER INTERFACE: Show subtitle
  //DESCRIPTION: Shows a subtitle
  //OUTPUT: Widget for subtitle
  Widget showSubtitle() {
    return Text(
      name,
      style: TextStyle(
          color: themes.getColor(context, "homeSubtitleTextColor"),
          fontSize: Theme.of(context).textTheme.homeSubtitleFontSize,
          fontWeight: Theme.of(context).typography.homeSubtitleFontWeight,
          fontStyle: FontStyle.italic),
    );
  }

  //USER INTERFACE: Show settings dropdown
  //DESCRIPTION: Shows a dropdown with 'signOut', 'themeSelector', and 'delete'
  //          each with the appropriate gestureDetector actions
  //OUTPUT: Widget for settings dropdown
  Widget showSettingsDropdown() {
    return new DropdownButtonHideUnderline(
        child: DropdownButton(
      dropdownColor: themes.getColor(context, "homeSettingsDropdownColor"),
      icon: Icon(Icons.more_vert,
          color: themes.getColor(context, "homeSettingsDropdownIconColor"),
          size: themes.getDimension(
              context, true, "homeSettingsDropdownIconDimension")),
      onChanged: (_) {},
      items: [
        DropdownMenuItem(
            onTap: () {},
            child: Center(
              child: Container(
                  width: 100,
                  child: interfaceStandards.showThemeSelector(context)),
            )),
        DropdownMenuItem(
            onTap: () {
              cloudFirestore.signOut().then((next) {
                routeNavigation.routeSignOutWelcome(context);
              });
            },
            child: Center(
              child: Text(
                getTranslated(context, "homeSettingsDropdownSignOut"),
                style: TextStyle(
                  color: themes.getColor(
                      context, "homeSettingsDropdownSignOutTextColor"),
                ),
              ),
            )),
        DropdownMenuItem(
            onTap: () {
              cloudFirestore.deleteUser().then(
                  (next) => {routeNavigation.routeSignOutWelcome(context)});
            },
            child: Center(
              child: Text(
                getTranslated(context, "homeSettingsDropdownDeleteAccount"),
                style: TextStyle(
                  color: themes.getColor(
                      context, "homeSettingsDropdownDeleteAccountTextColor"),
                ),
              ),
            )),
      ],
    ));
  }

  //USER INTERFACE: Show navigation bar floating action button
  //DESCRIPTION: Shows icon and loads camera function on tap
  //OUTPUT: Navigation bar floating action button with gesture detector function
  Widget showNavigationBarFloatingActionButton() {
    return new Center(
        heightFactor: 0.45,
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
                Icons.grid_view,
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
                Icons.calendar_today_outlined,
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
                Icons.bookmark_border_outlined,
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

  //USER INTERFACE: Show image container
  //DESCRIPTION: Takes in a list of images and makes a decision. If the current
  //          index is '0' then we call the showImageList() function, otherwise
  //          we call the showImageGrid() function
  //OUTPUT: Cards with images and text for new month
  Widget showImageContainer() {
    return Container(
      height: themes.getDimension(context, true, "homeImageContainerDimension"),
      width: themes.getDimension(context, false, "homeImageContainerDimension"),
      child: FutureBuilder(
        future: cloudFirestore.getImageDocuments(),
        builder: (BuildContext context, snapshot) {
          documentSnapshots = snapshot.data ?? [];
          if (snapshot.hasData) {
            interfaceStandards.showProgress(context);
          } else {
            //Empty container widget
          }
          return currentIndex == 0 ? showImageList(snapshot) : showImageGrid();
        },
      ),
    );
  }

  //USER INTERFACE: Show image list
  //DESCRIPTION: Takes in a list of images and displays each one in a card in
  //          a list view for the user
  //OUTPUT: Cards with images and text for new month in a list format
  Widget showImageList(AsyncSnapshot<dynamic> snapshot) {
    return ScrollSnapList(
      onItemFocus: onItemFocus,
      scrollDirection: Axis.horizontal,
      itemSize:
          themes.getDimension(context, false, "homeImageListCardDimension"),
      focusOnItemTap: true,
      reverse: true,
      dynamicItemSize: true,
      dynamicItemOpacity: 0.85,
      dynamicSizeEquation: customEquation,
      itemCount: documentSnapshots.length,
      itemBuilder: (context, int index) {
        DocumentSnapshot documentSnapshot = documentSnapshots[index];
        return showImageCard(documentSnapshot, true);
      },
    );
  }

  //USER INTERFACE: Show image grid
  //DESCRIPTION: Takes in a list of images and displays each one in a card in
  //          a grid view for the user
  //OUTPUT: Cards with images and text for new month in a grid format
  Widget showImageGrid() {
    return interfaceStandards.parentCenter(
        context,
        Container(
          height: 100,
          width: 100,
          color: Colors.black,
        ));
  }

  //USER INTERFACE: Show image card
  //DESCRIPTION: Takes in the information for one image from the list and creates
  //          a card for it to display the information. When you tap on it, it
  //          should display full screen, long press should delete it
  //DOCUMENTSNAPSHOT INPUT: 'documentSnapshot' for having something to reference
  //OUTPUT: Card with image
  Widget showImageCard(DocumentSnapshot documentSnapshot, bool isList) {
    //VARIBLE INITIALIZATION
    String date = documentSnapshot.id.toString();
    int monthNumber = int.parse(date.substring(5, 7));
    String month = methodStandards.getCurrentMonth(context, monthNumber);
    String imageURL = documentSnapshot.get("imageURL");

    //USER INTERFACE: Show image card
    return GestureDetector(
      onTap: () {
        routeNavigation.routeDetail(context, imageURL);
      },
      onLongPress: () {
        setState(() {
          cloudFirestore.deleteImageData(documentSnapshot, imageURL);
        });
      },
      child: Hero(
        tag: 'imageCard$imageURL',
        child: Stack(
          children: [
            Container(
              width: themes.getDimension(
                  context, false, "homeImageListCardDimension"),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50.0),
                  color: themes.getColor(context, "homeImageListCardColor"),
                  image: DecorationImage(
                      image: NetworkImage(
                        imageURL,
                      ),
                      fit: BoxFit.cover)),
            ),
            Positioned(
                bottom: 20,
                child: Container(
                  width: themes.getDimension(
                      context, false, "homeImageListCardDimension"),
                  child: Center(
                    child: Text(
                      isList
                          ? month +
                              " " +
                              date.substring(8, 10) +
                              ", '" +
                              date.substring(2, 4)
                          : date.substring(8, 10),
                      style: TextStyle(
                          fontSize: 25,
                          color: Colors.white,
                          fontStyle: FontStyle.italic),
                    ),
                  ),
                ))
          ],
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
              child: showHelloTitle(),
            ),
            Positioned(
                top: themes.getPosition(context, true, "homeSubtitlePosition"),
                left:
                    themes.getPosition(context, false, "homeSubtitlePosition"),
                child: showSubtitle()),
            Positioned(
              top: themes.getPosition(
                  context, true, "homeSettingsDropdownPosition"),
              right: themes.getPosition(
                  context, false, "homeSettingsDropdownPosition"),
              child: showSettingsDropdown(),
            ),
            Positioned(
              top: themes.getPosition(
                  context, true, "homeTitleBodyDividerPosition"),
              child: interfaceStandards.parentCenter(
                  context,
                  Container(
                    width: themes.getDimension(
                        context, false, "homeTitleBodyDividerDimension"),
                    child: Divider(
                      color:
                          themes.getColor(context, "homeTitleBodyDividerColor"),
                      thickness: 2,
                    ),
                  )),
            ),
            Positioned(
              top: themes.getPosition(context, true, "homeImageListPosition"),
              child: showImageContainer(),
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
