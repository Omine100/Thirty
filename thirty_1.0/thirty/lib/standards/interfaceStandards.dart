import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intro_slider/slide_object.dart';

import 'package:thirty/languages/languages.dart';
import 'package:thirty/standards/themes.dart';
import 'package:thirty/standards/methodStandards.dart';

class InterfaceStandards {
  //Class initialization
  Themes themes = new Themes();

  //User interface: Parent center
  Widget parentCenter(BuildContext context, Widget child) {
    return Container(
      width: themes.getDimension(
          context, false, "interfaceStandardsParentCenterContainerDimension"),
      child: Center(
        child: child,
      ),
    );
  }

  //User interface: Back button
  Widget backButton(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: Icon(Icons.keyboard_backspace,
          color: themes.getColor(context, "interfaceStandardsBackButtonColor"),
          size: themes.getDimension(
              context, true, "interfaceStandardsBackButtonIconDimension")),
    );
  }

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

  //User interface: Show progress
  Widget showProgress(BuildContext context) {
    return new CircularProgressIndicator(
      backgroundColor:
          themes.getColor(context, "interfaceStandardsProgressIndicatorColor"),
    );
  }

  //User interface: Slide creation
  List<Slide> slideCreation(BuildContext context) {
    List<Slide> slides = new List<Slide>();
    slides.add(newSlide(context, getTranslated(context, "introExerciseTitle"),
        getTranslated(context, "introExerciseDescription")));
    slides.add(newSlide(context, getTranslated(context, "introCalendarTitle"),
        getTranslated(context, "introCalendarDescription")));
    slides.add(newSlide(context, getTranslated(context, "introMedalTitle"),
        getTranslated(context, "introMedalDescription")));
    return slides;
  }

  //User interface: New slide
  Slide newSlide(BuildContext context, String title, String description) {
    Slide slide = new Slide(
      title: title,
      styleTitle: TextStyle(
          color: themes.getColor(context, "introTitleColor"),
          fontSize: Theme.of(context).textTheme.introTitleFontSize,
          fontWeight: Theme.of(context).typography.introTitleFontWeight),
      description: description,
      styleDescription: TextStyle(
        color: themes.getColor(context, "introDescriptionColor"),
        fontSize: Theme.of(context).textTheme.introDescriptionFontSize,
        fontWeight: Theme.of(context).typography.introDescriptionFontWeight,
      ),
    );
    return slide;
  }
}
