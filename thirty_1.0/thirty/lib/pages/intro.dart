import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:intro_slider/slide_object.dart';
import 'package:intro_slider/dot_animation_enum.dart';

import 'package:thirty/services/root.dart';
import 'package:thirty/standards/themes.dart';
import 'package:thirty/standards/themesGradients.dart';
import 'package:thirty/standards/interfaceStandards.dart';

class IntroScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  //Class initialization
  Themes themes = new Themes();
  ThemesGradients themesGradients = new ThemesGradients();
  InterfaceStandards interfaceStandards = new InterfaceStandards();

  //Varaible initialization
  List<Slide> slides = new List();
  Function goToTab;

  //Mechanics: Initial state
  @override
  void initState() {
    super.initState();
    slides.add(
      new Slide(
        title: "GOALS",
        styleTitle: TextStyle(
            color: Theme.of(context).colorScheme.introTitleColor,
            fontSize: Theme.of(context).textTheme.introTitleFontSize,
            fontWeight: Theme.of(context).typography.introTitleFontWeight),
        description: "Testing testing",
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
        styleDescription: TextStyle(
          color: Theme.of(context).colorScheme.introDescriptionColor,
          fontSize: Theme.of(context).textTheme.introDescriptionFontSize,
          fontWeight: Theme.of(context).typography.introDescriptionFontWeight,
        ),
      ),
    );
  }

  //Mechanics: Switching to the next slide
  void onTabChangeCompleted(index) {
    //Index of current slide is focused
  }

  //Mechanics: Route to home screen
  void onDonePress() async {
    Navigator.pop(context);
    Navigator.pushReplacementNamed(context, "/RootScreen");
  }

  //User interface: Show interface button
  Widget showInterfaceButton(String type) {
    return Container(
      height:
          themes.getDimension(context, true, "introInterfaceButtonDimension"),
      width:
          themes.getDimension(context, false, "introInterfaceButtonDimension"),
      child: Icon(
        type == "navigate_next"
            ? Icons.navigate_next
            : (type == "done" ? Icons.done : Icons.skip_next),
        color: Colors.grey.shade700,
        size: themes.getDimension(
            context, true, "introInterfaceButtonIconDimension"),
      ),
    );
  }

  //USER INTERFACE: SHOW LIST AND TABS
  List<Widget> renderListCustomTabs() {
    List<Widget> tabs = new List();
    for (int i = 0; i < slides.length; i++) {
      Slide currentSlide = slides[i];
      tabs.add(Container(
        width: double.infinity,
        height: double.infinity,
        child: Container(
          margin: EdgeInsets.only(bottom: 60.0, top: 60.0),
          child: ListView(
            children: <Widget>[
              Container(
                child: Text(
                  currentSlide.title,
                  style: currentSlide.styleTitle,
                  textAlign: TextAlign.center,
                ),
                margin: EdgeInsets.only(top: 20.0),
              ),
              Container(
                child: Text(
                  currentSlide.description,
                  style: currentSlide.styleDescription,
                  textAlign: TextAlign.center,
                  maxLines: 5,
                  overflow: TextOverflow.ellipsis,
                ),
                margin: EdgeInsets.only(top: 20.0),
              ),
            ],
          ),
        ),
      ));
    }
    return tabs;
  }

  //USER INTERFACE: INTRO SCREEN
  @override
  Widget build(BuildContext context) {
    return new IntroSlider(
      slides: this.slides,
      renderSkipBtn: this.showInterfaceButton("skip_next"),
      renderNextBtn: this.showInterfaceButton("navigate_next"),
      renderDoneBtn: this.showInterfaceButton("done"),
      onDonePress: this.onDonePress,
      colorDot: Theme.of(context).colorScheme.introDotColor,
      sizeDot: themes.getDimension(context, true, "introDotDimension"),
      typeDotAnimation: dotSliderAnimation.SIZE_TRANSITION,
      listCustomTabs: this.renderListCustomTabs(),
      backgroundColorAllSlides: Theme.of(context).backgroundColor, //This one
      refFuncGoToTab: (refFunc) {
        this.goToTab = refFunc;
      },
      shouldHideStatusBar: false,
      onTabChangeCompleted: this.onTabChangeCompleted,
    );
  }
}
