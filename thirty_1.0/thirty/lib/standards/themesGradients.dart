import 'package:flutter/material.dart';

import 'package:thirty/standards/themes.dart';

class ThemesGradients {
  //Variable initilization
  Themes themes = new Themes();

  //User interface: Text linear gradient
  Shader textLinearGradient(
      BuildContext context, Color topLeftColor, Color bottomRightColor) {}

  //User interface: Body linear gradient
  LinearGradient bodyLinearGradient(
      BuildContext context, Color topLeftColor, Color bottomRightColor) {}

  //User interface: Card linear gradient
  //I may make these a bit blurred
  LinearGradient cardLinearGradient(
      BuildContext context, Color topLeftColor, Color bottomRightColor) {}
}
