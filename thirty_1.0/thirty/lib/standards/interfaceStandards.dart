import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intro_slider/slide_object.dart';

import 'package:thirty/services/appLocalizations.dart';
import 'package:thirty/standards/themes.dart';

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
          color:
              Theme.of(context).colorScheme.interfaceStandardsBackButtonColor,
          size: themes.getDimension(
              context, true, "interfaceStandardsBackButtonIconDimension")),
    );
  }

  //User interface: Show title
  Widget showTitle(BuildContext context, String key) {
    return parentCenter(
      context,
      Text(
        AppLocalizations.of(context).translate(key),
        style: TextStyle(
            color:
                Theme.of(context).colorScheme.interfaceStandardsTitleTextColor,
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
      backgroundColor: Theme.of(context)
          .colorScheme
          .interfaceStandardsProgressIndicatorColor,
    );
  }

  //User interface: Slide creation
  List<Slide> slideCreation(BuildContext context) {
    List<Slide> slides = new List<Slide>();
    slides.add(newSlide(
        context,
        AppLocalizations.of(context).translate("introExerciseTitle"),
        AppLocalizations.of(context).translate("introExerciseDescription")));
    slides.add(newSlide(
        context,
        AppLocalizations.of(context).translate("introCalendarTitle"),
        AppLocalizations.of(context).translate("introCalenderDescription")));
    slides.add(newSlide(
        context,
        AppLocalizations.of(context).translate("introMedalTitle"),
        AppLocalizations.of(context).translate("introMedalDescription")));
    return slides;
  }

  //User interface: New slide
  Slide newSlide(BuildContext context, String title, String description) {
    Slide slide = new Slide(
      title: title,
      styleTitle: TextStyle(
          color: Theme.of(context).colorScheme.introTitleColor,
          fontSize: Theme.of(context).textTheme.introTitleFontSize,
          fontWeight: Theme.of(context).typography.introTitleFontWeight),
      description: description,
      styleDescription: TextStyle(
        color: Theme.of(context).colorScheme.introDescriptionColor,
        fontSize: Theme.of(context).textTheme.introDescriptionFontSize,
        fontWeight: Theme.of(context).typography.introDescriptionFontWeight,
      ),
    );
    return slide;
  }
}
