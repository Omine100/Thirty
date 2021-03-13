import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:intro_slider/slide_object.dart';
import 'package:intro_slider/dot_animation_enum.dart';

import 'package:thirty/services/routeNavigation.dart';
import 'package:thirty/services/cloudFirestore.dart';
import 'package:thirty/standards/languageStandards.dart';
import 'package:thirty/standards/themes.dart';
import 'package:thirty/standards/gradientStandards.dart';
import 'package:thirty/standards/interfaceStandards.dart';

class IntroScreen extends StatefulWidget {
  IntroScreen({this.email, this.password});

  //Variable references
  final String email, password;

  @override
  State<StatefulWidget> createState() => new _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  //Class initialization
  RouteNavigation routeNavigation = new RouteNavigation();
  CloudFirestore cloudFirestore = new CloudFirestore();
  Themes themes = new Themes();
  GradientStandards gradientStandards = new GradientStandards();
  InterfaceStandards interfaceStandards = new InterfaceStandards();

  //Variable initialization
  List<Slide> slides = new List<Slide>();

  //Mechanics: Slide creation
  List<Slide> slideCreation() {
    slides.add(newSlide(getTranslated(context, "introExerciseTitle"),
        getTranslated(context, "introExerciseDescription")));
    slides.add(newSlide(getTranslated(context, "introCalendarTitle"),
        getTranslated(context, "introCalendarDescription")));
    slides.add(newSlide(getTranslated(context, "introMedalTitle"),
        getTranslated(context, "introMedalDescription")));
    return slides;
  }

  //User interface: New slide
  Slide newSlide(String title, String description) {
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

  //Mechanics: Route to home screen
  void onDonePress() async {
    cloudFirestore.signIn(widget.email, widget.password);
    routeNavigation.RouteHome(context);
  }

  //User interface: Show interface button
  Widget showInterfaceButton(String type) {
    return Container(
      height:
          themes.getDimension(context, true, "introInterfaceButtonDimension"),
      width:
          themes.getDimension(context, false, "introInterfaceButtonDimension"),
      child: Icon(
        type == "navigate_next" ? Icons.navigate_next : Icons.done,
        color: themes.getColor(context, "introInterfaceButtonColor"),
        size: themes.getDimension(
            context, true, "introInterfaceButtonIconDimension"),
      ),
    );
  }

  //User interface: Show list and tabs
  List<Widget> renderListCustomTabs() {
    List<Widget> tabs = new List();
    for (int i = 0; i < slides.length; i++) {
      Slide currentSlide = slides[i];
      tabs.add(Container(
        decoration: BoxDecoration(
            gradient: gradientStandards.bodyLinearGradient(
                context,
                themes.getColor(context, "backgroundGradientTopRightColor"),
                themes.getColor(context, "backgroundGradientBottomLeftColor"),
                false)),
        width: double.infinity,
        height: double.infinity,
        child: Container(
          margin:
              EdgeInsets.only(bottom: 60.0, top: 35.0, left: 50.0, right: 50.0),
          child: ListView(
            children: <Widget>[
              Text(
                currentSlide.title,
                style: currentSlide.styleTitle,
                textAlign: TextAlign.center,
              ),
              Container(
                margin: EdgeInsets.only(top: i == 1 ? 60 : 20, bottom: 20),
                child:
                  i == 0
                      ? Lottie.asset('lib/assets/introExerciseAnimation.json',
                          repeat: true)
                      : (i == 1
                          ? Lottie.asset(
                              'lib/assets/introCalendarAnimation.json',
                              repeat: true,
                            )
                          : Lottie.asset('lib/assets/introMedalAnimation.json',
                              repeat: true)),
              ),
              Text(
                currentSlide.description,
                style: currentSlide.styleDescription,
                textAlign: TextAlign.center,
                maxLines: 5,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ));
    }
    return tabs;
  }

  //User interface: Intro screen
  @override
  Widget build(BuildContext context) {
    return new IntroSlider(
      slides: slideCreation(),
      isShowSkipBtn: false,
      renderNextBtn: this.showInterfaceButton("navigate_next"),
      renderDoneBtn: this.showInterfaceButton("done"),
      onDonePress: this.onDonePress,
      colorDot: themes.getColor(context, "introDotcolor"),
      sizeDot: themes.getDimension(context, true, "introDotDimension"),
      typeDotAnimation: dotSliderAnimation.SIZE_TRANSITION,
      listCustomTabs: this.renderListCustomTabs(),
      shouldHideStatusBar: false,
    );
  }
}
