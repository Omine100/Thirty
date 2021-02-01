import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:thirty/services/routeNavigation.dart';
import 'package:thirty/standards/themes.dart';
import 'package:thirty/standards/languageStandards.dart';

class InterfaceStandards {
  //Class initialization
  Themes themes = new Themes();
  RouteNavigation routeNavigation = new RouteNavigation();

  //User interface: Theme selector
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

  //User interface: Language selector
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

  //User interface: Show progress
  Widget showProgress(BuildContext context) {
    return new CircularProgressIndicator(
      backgroundColor:
          themes.getColor(context, "interfaceStandardsProgressIndicatorColor"),
    );
  }

  //User interface: Show waiting screen
  Widget showWaitingScreen() {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: CircularProgressIndicator(),
      ),
    );
  }

  //User interface: Parent center
  Widget parentCenter(BuildContext context, Widget widget) {
    return Container(
      width: themes.getDimension(
          context, false, "interfaceStandardsParentCenterContainerDimension"),
      child: Center(
        child: widget,
      ),
    );
  }

  //User interface: Back button
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

  //User interface: Show title
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

  //User interface: Show text field
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
          key != getTranslated(context, "inputEmail")
              ? key == getTranslated(context, "inputPassword")
                  ? Icons.lock
                  : Icons.person
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
