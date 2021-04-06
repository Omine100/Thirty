import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:thirty/services/routeNavigation.dart';
import 'package:thirty/standards/themes.dart';
import 'package:thirty/standards/languageStandards.dart';

class InterfaceStandards {
  //CLASS INITIALIZATION
  Themes themes = new Themes();
  RouteNavigation routeNavigation = new RouteNavigation();

  //USER INTERFACE: Theme selector
  //DESCRIPTION: Allows the user to switch between 'light' and 'dark' modes
  //OUTPUT: Slider widget selector
  //ON-CHANGED: Notifies ThemeNotifier about the change to the theme
  Widget themeSelector(BuildContext context) {
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
        },
        value: notifier.darkTheme,
      ),
    );
  }

  //USER INTERFACE: Language selector
  //OUTPUT: Dropdown widget selector
  //ON-CHANGED: Calls a method in languageStandards to change the language
  Widget languageSelector(BuildContext context) {
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

  //USER INTERFACE: Back button
  //OUTPUT: Calls a function in routeNavigation to pop the route stack once
  Widget backButton(BuildContext context) {
    return GestureDetector(
      onTap: () {
        routeNavigation.RoutePop(context);
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

  //USER INTERFACE: Show text field
  //DESCRIPTION: Takes input for various forms in a general way
  //INT INPUT: 'keyboardType' where '0' is email and '!0' is text
  //BOOLEAN INPUT: 'isVisible' where true makes the input visible to the user
  //STRING INPUT: 'key' used to get the text and its correct translation
  //FUNCTION INPUT: 'onSaved' function for saving the input
  //OUTPUT: Text form field widget customized to inputs
  Widget showTextField(BuildContext context, int keyboardType, bool isVisible,
      String key, Function onSaved) {
    return TextFormField(
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
          ? "$key " + getTranslated(context, "inputValidator")
          : null,
      onSaved: onSaved,
    );
  }
}
