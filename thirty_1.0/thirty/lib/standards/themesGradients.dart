import 'package:flutter/material.dart';

import 'package:thirty/standards/themes.dart';

class ThemesGradients {
  //Variable initilization
  Themes themes = new Themes();

  //User interface: Text linear gradient
  Shader textLinearGradient(
      BuildContext context, Color topLeftColor, Color bottomRightColor) {
    final Shader linearGradient =
        LinearGradient(colors: <Color>[topLeftColor, bottomRightColor])
            .createShader(Rect.fromLTWH(110.0, 110.0, 200.0, 70.0));
    return linearGradient;
  }

  //User interface: Body linear gradient
  LinearGradient bodyLinearGradient(BuildContext context, Color topLeftColor,
      Color bottomRightColor, bool isSmall) {
    final LinearGradient linearGradient = LinearGradient(
      begin: isSmall ? Alignment.centerLeft : Alignment.topLeft,
      end: Alignment.bottomRight,
      tileMode: TileMode.mirror,
      colors: <Color>[topLeftColor, bottomRightColor],
    );
    return linearGradient;
  }

  //User interface: Card linear gradient
  //I may make these a bit blurred
  LinearGradient cardLinearGradient(
      BuildContext context, Color topLeftColor, Color bottomRightColor) {
    final LinearGradient linearGradient = LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      tileMode: TileMode.mirror,
      colors: <Color>[topLeftColor, bottomRightColor],
    );
  }
}
