import 'package:flutter/material.dart';

import 'package:thirty/standards/themes.dart';

class GradientStandards {
  //CLASS INITIALIZATION
  Themes themes = new Themes();

  //USER INTERFACE:: Text linear gradient
  //DESCRIPTION: Simple linear gradient that I think looks nice for text
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
  //DESCRIPTION: More complex linear gradient for backgrounds
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
