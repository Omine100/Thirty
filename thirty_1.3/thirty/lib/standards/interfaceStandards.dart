import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:thirty/services/cloudFirestore.dart';
import 'package:thirty/services/routeNavigation.dart';
import 'package:thirty/services/mediaManagement.dart';
import 'package:thirty/standards/themes.dart';
import 'package:thirty/standards/languageStandards.dart';

class InterfaceStandards {
  //CLASS INITIALIZATION
  Themes themes = new Themes();
  CloudFirestore cloudFirestore = new CloudFirestore();
  RouteNavigation routeNavigation = new RouteNavigation();
  MediaManagement mediaManagement = new MediaManagement();

  //USER INTERFACE: Parent center
  //WIDGET INPUT: Any widget that you want centered
  //OUTPUT: Widget centered in next parent in the tree
  Widget parentCenter(BuildContext context, Widget widget) {
    return Container(
      width: themes.getDimension(
          context, false, "interfaceStandardsParentCenterContainerDimension"),
      child: Center(
        child: widget,
      ),
    );
  }

  //USER INTERFACE: Show theme selector
  //DESCRIPTION: Allows the user to switch between 'light' and 'dark' modes
  //OUTPUT: Slider widget selector
  //ON-CHANGED: Notifies ThemeNotifier about the change to the theme
  Widget showThemeSelector(BuildContext context) {
    return Consumer<ThemeNotifier>(
      builder: (context, notifier, child) => SwitchListTile(
        inactiveThumbImage: AssetImage(
            'lib/assets/interfaceStandardsThemeSelectorMoonImage.png'),
        activeThumbImage: AssetImage(
            'lib/assets/interfaceStandardsThemeSelectorSunImage.png'),
        activeColor:
            themes.getColor(context, "interfaceStandardsThemeSelectorColor"),
        inactiveThumbColor:
            themes.getColor(context, "interfaceStandardsThemeSelectorColor"),
        onChanged: (val) {
          notifier.toggleTheme();
          routeNavigation.routePop(context);
        },
        value: notifier.darkTheme,
      ),
    );
  }

  //USER INTERFACE: Show language selector
  //OUTPUT: Dropdown widget selector
  //ON-CHANGED: Calls a method in languageStandards to change the language
  Widget showLanguageSelector(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton(
        dropdownColor:
            themes.getColor(context, "interfaceStandardsLanguageSelectorColor"),
        onChanged: (Languages languages) {
          languages.changeLanguage(context, languages);
        },
        icon: Icon(
          Icons.language,
          color: themes.getColor(
              context, "interfaceStandardsLanguageSelectorButtonColor"),
          size: themes.getDimension(context, true,
              "interfaceStandardsLanguageSelectorButtonDimension"),
        ),
        items: Languages.getLanguageList()
            .map<DropdownMenuItem<Languages>>((lang) => DropdownMenuItem(
                value: lang,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Text(
                      lang.name,
                      style: TextStyle(
                        color: themes.getColor(context,
                            "interfaceStandardsLanguageSelectorTextColor"),
                      ),
                    ),
                    Text(
                      lang.flag,
                      style: TextStyle(
                          color: themes.getColor(context,
                              "interfaceStandardsLanguageSelectorTextColor")),
                    ),
                  ],
                )))
            .toList(),
      ),
    );
  }

  //USER INTERFACE: Show progress
  //DESCRIPTION: Shows a typical progress wheel
  //OUTPUT: A progress wheel centered
  Widget showProgress(BuildContext context) {
    return parentCenter(
      context,
      CircularProgressIndicator(
        backgroundColor: themes.getColor(
            context, "interfaceStandardsProgressIndicatorColor"),
      ),
    );
  }

  //USER INTERFACE: Show waiting screen
  //DESCRIPTION: Shows a whole screen with a centered progress wheel
  //OUTPUT: A screen with a progress wheel centered
  //USES: Before the application is loaded
  Widget showWaitingScreen(BuildContext context) {
    return Scaffold(body: parentCenter(context, CircularProgressIndicator()));
  }

  //USER INTERFACE: Show toast message
  //BUILDCONTEXT INPUT: 'context' - must be a decendent of scaffold otherwise
  //                "ScaffoldMessenger.of()" will return null
  //STRING INPUT: 'key' - What is to be displayed on the toast message after
  //          being translated
  //OUTPUT: Toast message
  void showToastMessage(BuildContext context, String key) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        getTranslated(context, key),
        style: TextStyle(
            color: themes.getColor(
                context, "interfaceStandardsToastMessageContentColor"),
            fontSize: Theme.of(context)
                .textTheme
                .interfaceStandardsToastMessageContentFontSize,
            fontWeight: Theme.of(context)
                .typography
                .interfaceStandardsToastMessageContentFontWeight),
      ),
      duration: const Duration(seconds: 3),
      backgroundColor: themes.getColor(
          context, "interfaceStandardsToastMessageBackgroundColor"),
    ));
  }

  //USER INTERFACE: Show media selection dialog
  //DESCRIPTION: Gives the user a choice between camera and gallery for photo
  //          retrieval and then gives the necessary information to home.dart
  //STATE INPUT: 'state' for sending over to mediaManagement for setState()
  //OUTPUT: Widget for media selection dialog
  Future<void> showMediaSelectionDialog(BuildContext context, State state) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: Text(getTranslated(context, "mediaSelectionTitle")),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    GestureDetector(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.image,
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 8),
                          ),
                          Text(getTranslated(context, "mediaSelectionGallery")),
                        ],
                      ),
                      onTap: () {
                        mediaManagement.getImage(context, false, state);
                        routeNavigation.routePop(context);
                      },
                    ),
                    Padding(padding: EdgeInsets.all(8.0)),
                    GestureDetector(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.camera_alt_rounded,
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 8),
                          ),
                          Text(
                            getTranslated(context, "mediaSelectionCamera"),
                          ),
                        ],
                      ),
                      onTap: () {
                        mediaManagement.getImage(context, true, state);
                        routeNavigation.routePop(context);
                      },
                    )
                  ],
                ),
              ));
        });
  }

  //USER INTERFACE: Show share button
  //DESCRIPTION: Shows a button and then tap, takes the imageURL and allows for
  //          the user to share it via a function call
  //STRING INPUT: 'imageURL' for image to share
  //OUTPUT: Widget and share function call
  Widget showShareButton(BuildContext context, String imageURL) {
    return new Material(
      color: themes.getColor(context, "materialTransparentColor"),
      child: IconButton(
        onPressed: () {
          mediaManagement.saveAndShare(imageURL);
        },
        iconSize: themes.getDimension(
            context, true, "interfaceStandardsShareButtonIconDimension"),
        icon: Icon(
          Icons.share_outlined,
          color: themes.getColor(
              context, "interfaceStandardsShareButtonIconColor"),
        ),
      ),
    );
  }

  //USER INTERFACE: Show back button
  //OUTPUT: Calls a function in routeNavigation to pop the route stack once
  Widget showBackButton(BuildContext context) {
    return GestureDetector(
      onTap: () {
        routeNavigation.routePop(context);
      },
      child: Icon(
        Icons.keyboard_backspace,
        color: themes.getColor(context, "interfaceStandardsBackButtonColor"),
        size: themes.getDimension(
            context, true, "interfaceStandardsBackButtonDimension"),
      ),
    );
  }

  //USER INTERFACE: Show title
  //DESCRIPTION: Shows a standard title for the application
  //STRING INPUT: 'key' used to get the text and its correct translation
  //OUTPUT: Text displayed in a general way for the application
  Widget showTitle(BuildContext context, String key) {
    return parentCenter(
      context,
      Text(
        getTranslated(context, key),
        style: TextStyle(
            color: themes.getColor(context, "interfaceStandardsTitleTextColor"),
            fontSize:
                Theme.of(context).textTheme.interfaceStandardsTitleFontSize,
            fontWeight:
                Theme.of(context).typography.interfaceStandardsTitleFontWeight),
      ),
    );
  }

  //USER INTERFACE: Show social icon button
  //DESCRIPTION: Widget for various icons with connection to cloudFirestore
  //INT INPUT: 'iconCase' - 0 = Google, 1 = Twitter
  Widget showSocialIconButton(BuildContext context, int iconCase) {
    //VARIABLE INITIALIZATION
    bool isNewUser;

    //USER INTERFACE: Show social icon button
    return new GestureDetector(
      onTap: () {
        iconCase == 0
            ? cloudFirestore.signInGoogle().then((_isNewUser) => isNewUser)
            : cloudFirestore.signInTwitter().then((_isNewUser) => isNewUser);
        if (isNewUser) {
          routeNavigation.routeHome(context);
        } else {
          routeNavigation.routeIntro(context);
        }
      },
      child: Container(
        padding: EdgeInsets.all(7.5),
        height: themes.getDimension(
            context, true, "welcomeSocialSignInButtonDimension"),
        width: themes.getDimension(
            context, true, "welcomeSocialSignInButtonDimension"),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(360),
          color: themes.getColor(context, "welcomeSocialSignInButtonColor"),
        ),
        child: Image(
          image: iconCase == 0
              ? AssetImage('lib/assets/googleLogo.png')
              : AssetImage('lib/assets/twitterLogo.png'),
        ),
      ),
    );
  }

  //USER INTERFACE: Show text field
  //DESCRIPTION: Takes input for various forms in a general way
  //INT INPUT: 'keyboardType' where '0' is email and '!0' is text
  //BOOLEAN INPUT: 'isVisible' where true makes the input visible to the user
  //STRING INPUT: 'key' used to get the text and its correct translation
  //FUNCTION INPUT: 'onSaved' function for saving the input
  //OUTPUT: Text form field widget customized to inputs
  Widget showTextField(BuildContext context, int keyboardType, bool isVisible,
      String key, Function onSaved, IconButton iconButton) {
    return TextFormField(
      autofocus: false,
      keyboardType:
          keyboardType == 0 ? TextInputType.emailAddress : TextInputType.text,
      style: TextStyle(
        color: themes.getColor(context, "interfaceStandardsTextInputColor"),
        fontSize:
            Theme.of(context).textTheme.interfaceStandardsTextInputFontSize,
      ),
      decoration: InputDecoration(
        prefixIcon: Icon(
          key != "inputEmail"
              ? (key == "inputPassword" ? Icons.lock : Icons.person)
              : Icons.email,
          color:
              themes.getColor(context, "interfaceStandardsTextInputIconColor"),
        ),
        suffixIcon: iconButton != null ? iconButton : null,
        hintText: getTranslated(context, key),
        hintStyle: TextStyle(
          color: themes.getColor(context, "interfaceStandardsTextInputColor"),
        ),
        labelStyle: TextStyle(
          color: themes.getColor(context, "interfaceStandardsTextInputColor"),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: themes.getColor(
                context, "interfaceStandardsTextInputLineColor"),
          ),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: themes.getColor(context, "interfaceStandardsTextInputColor"),
          ),
        ),
      ),
      obscureText: !isVisible,
      maxLines: 1,
      validator: (value) => value.isEmpty
          ? ("$key " + getTranslated(context, "inputValidator"))
          : null,
      onSaved: onSaved,
    );
  }
}
