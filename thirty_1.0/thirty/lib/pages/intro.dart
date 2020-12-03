import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:intro_slider/slide_object.dart';
import 'package:intro_slider/dot_animation_enum.dart';

import 'package:thirty/standards/themes.dart';
import 'package:thirty/standards/themesGradients.dart';
import 'package:thirty/standards/interfaceStandards.dart';

class IntroScreen extends StatefulWidget {
  IntroScreen({this.slides});

  //Variable reference
  final List<Slide> slides;

  @override
  State<StatefulWidget> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  //Class initialization
  Themes themes = new Themes();
  ThemesGradients themesGradients = new ThemesGradients();
  InterfaceStandards interfaceStandards = new InterfaceStandards();

  //Varaible initialization
  Function goToTab;

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
        type == "navigate_next" ? Icons.navigate_next : Icons.done,
        color: Theme.of(context).colorScheme.introInterfaceButtonColor,
        size: themes.getDimension(
            context, true, "introInterfaceButtonIconDimension"),
      ),
    );
  }

  //USER INTERFACE: SHOW LIST AND TABS
  List<Widget> renderListCustomTabs() {
    List<Widget> tabs = new List();
    for (int i = 0; i < widget.slides.length; i++) {
      Slide currentSlide = widget.slides[i];
      tabs.add(Container(
        decoration: BoxDecoration(
            gradient: themesGradients.bodyLinearGradient(
                context,
                Theme.of(context).colorScheme.backgroundGradientTopRightColor,
                Theme.of(context).colorScheme.backgroundGradientBottomLeftColor,
                false)),
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
                  child: i == 0
                      ? Lottie.asset('lib/assets/introExerciseAnimation.json',
                          repeat: true)
                      : (i == 1
                          ? Lottie.asset(
                              'lib/assets/introCalendarAnimation.json',
                              repeat: true,
                            )
                          : Lottie.asset('lib/assets/introMedalAnimation.json',
                              repeat: true))),
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
      slides: this.widget.slides,
      isShowSkipBtn: false,
      renderNextBtn: this.showInterfaceButton("navigate_next"),
      renderDoneBtn: this.showInterfaceButton("done"),
      onDonePress: this.onDonePress,
      colorDot: Theme.of(context).colorScheme.introDotColor,
      sizeDot: themes.getDimension(context, true, "introDotDimension"),
      typeDotAnimation: dotSliderAnimation.SIZE_TRANSITION,
      listCustomTabs: this.renderListCustomTabs(),
      refFuncGoToTab: (refFunc) {
        this.goToTab = refFunc;
      },
      shouldHideStatusBar: false,
      onTabChangeCompleted: this.onTabChangeCompleted,
    );
  }
}
