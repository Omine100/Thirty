import 'package:flutter/material.dart';

import 'package:thirty/standards/themes.dart';

class GradientStandards {
  //CLASS INITIALIZATION
  Themes themes = new Themes();

  //USER INTERFACE: Text linear gradient
  //COLOR INPUTS: 'topLeftColor', 'bottomRightColor'
  //OUTPUT: Linear gradient
  Shader textLinearGradient(
      BuildContext context, Color topLeftColor, Color bottomRightColor) {
    final Shader linearGradient =
        LinearGradient(colors: <Color>[topLeftColor, bottomRightColor])
            .createShader(Rect.fromLTWH(110.0, 110.0, 0.0, 0.0));
    return linearGradient;
  }

  //USER INTERFACE: Body linear gradient
  //COLOR INPUTS: 'topLeftColor', 'bottomRightColor'
  //BOOLEAN INPUT: 'isSmall' can be used to change the alignment from a center
  //              diagonal to a full diagonal
  //OUTPUT: Linear gradient
  LinearGradient bodyLinearGradient(BuildContext context, Color topLeftColor,
      Color bottomRightColor, bool isSmall) {
    final LinearGradient linearGradient = LinearGradient(
      begin: isSmall ? Alignment.centerRight : Alignment.topRight,
      end: Alignment.bottomLeft,
      colors: <Color>[topLeftColor, bottomRightColor],
    );
    return linearGradient;
  }
}

class Gradients {
  //CLASS INITIALIZATION
  GradientStandards gradientStandards = new GradientStandards();
  Themes themes = new Themes();

  //USER INTERFACE: Sign up button gradient
  Shader signUpButtonGradient(BuildContext context) {
    Shader shader = gradientStandards.textLinearGradient(
        context,
        themes.getColor(context, "backgroundGradientTopRightColor"),
        themes.getColor(context, "backgroundGradientBottomLeftColor"));
    return shader;
  }

  //USER INTERFACE: Welcome screen gradient
  LinearGradient welcomeScreenGradient(BuildContext context) {
    LinearGradient linearGradient = gradientStandards.bodyLinearGradient(
        context,
        themes.getColor(context, "backgroundGradientTopRightColor"),
        themes.getColor(context, "backgroundGradientBottomLeftColor"),
        false);
    return linearGradient;
  }

  //USER INTERFACE: Login screen gradient
  LinearGradient loginScreenGradient(BuildContext context) {
    LinearGradient linearGradient = gradientStandards.bodyLinearGradient(
        context,
        themes.getColor(context, "backgroundGradientTopRightColor"),
        themes.getColor(context, "backgroundGradientBottomLeftColor"),
        false);
    return linearGradient;
  }

  //USER INTERFACE: Forgot password screen gradient
  LinearGradient forgotPasswordScreenGradient(BuildContext context) {
    LinearGradient linearGradient = gradientStandards.bodyLinearGradient(
        context,
        themes.getColor(context, "backgroundGradientTopRightColor"),
        themes.getColor(context, "backgroundGradientBottomLeftColor"),
        false);
    return linearGradient;
  }
}
