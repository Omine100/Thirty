import 'package:flutter/material.dart';
import 'package:intro_slider/slide_object.dart';

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

  //User interface: Header text
  Widget headerText(BuildContext context, String header) {
    return parentCenter(
        context,
        Text(
          header,
          style: TextStyle(
            color:
                Theme.of(context).colorScheme.interfaceStandardsHeaderTextColor,
            fontSize: 45.0,
          ),
        ));
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
    slides.add(
      new Slide(
        title: "GOALS",
        styleTitle: TextStyle(
            color: Theme.of(context).colorScheme.introTitleColor,
            fontSize: Theme.of(context).textTheme.introTitleFontSize,
            fontWeight: Theme.of(context).typography.introTitleFontWeight),
        description: "Testing testing",
        colorBegin:
            Theme.of(context).colorScheme.backgroundGradientTopRightColor,
        colorEnd:
            Theme.of(context).colorScheme.backgroundGradientBottomLeftColor,
        directionColorBegin: Alignment.topRight,
        directionColorEnd: Alignment.bottomLeft,
        styleDescription: TextStyle(
          color: Theme.of(context).colorScheme.introDescriptionColor,
          fontSize: Theme.of(context).textTheme.introDescriptionFontSize,
          fontWeight: Theme.of(context).typography.introDescriptionFontWeight,
        ),
      ),
    );
    slides.add(
      new Slide(
        title: "CALENDAR",
        styleTitle: TextStyle(
            color: Theme.of(context).colorScheme.introTitleColor,
            fontSize: Theme.of(context).textTheme.introTitleFontSize,
            fontWeight: Theme.of(context).typography.introTitleFontWeight),
        description: "Testing testing",
        colorBegin:
            Theme.of(context).colorScheme.backgroundGradientTopRightColor,
        colorEnd:
            Theme.of(context).colorScheme.backgroundGradientBottomLeftColor,
        directionColorBegin: Alignment.topRight,
        directionColorEnd: Alignment.bottomLeft,
        styleDescription: TextStyle(
          color: Theme.of(context).colorScheme.introDescriptionColor,
          fontSize: Theme.of(context).textTheme.introDescriptionFontSize,
          fontWeight: Theme.of(context).typography.introDescriptionFontWeight,
        ),
      ),
    );
    slides.add(
      new Slide(
        title: "COMPLETION",
        styleTitle: TextStyle(
            color: Theme.of(context).colorScheme.introTitleColor,
            fontSize: Theme.of(context).textTheme.introTitleFontSize,
            fontWeight: Theme.of(context).typography.introTitleFontWeight),
        description: "Testing testing",
        colorBegin:
            Theme.of(context).colorScheme.backgroundGradientTopRightColor,
        colorEnd:
            Theme.of(context).colorScheme.backgroundGradientBottomLeftColor,
        directionColorBegin: Alignment.topRight,
        directionColorEnd: Alignment.bottomLeft,
        styleDescription: TextStyle(
          color: Theme.of(context).colorScheme.introDescriptionColor,
          fontSize: Theme.of(context).textTheme.introDescriptionFontSize,
          fontWeight: Theme.of(context).typography.introDescriptionFontWeight,
        ),
      ),
    );
    return slides;
  }
}
