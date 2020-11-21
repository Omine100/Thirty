import 'package:flutter/material.dart';

extension CustomColorScheme on ColorScheme {
  //Color get 'name' => const Color(0x'hexValue');
  Color get backgroundGradientTopLeftColor => const Color(0xFF0280EE);
  Color get backgroundGradientBottomRightColor => const Color(0xFF000D0);

  Color get interfaceStandardsBackButtonColor => const Color(0xFFFFFFFF);
  Color get interfaceStandardsHeaderTextColor => const Color(0xFFFFFFFF);
  Color get interfaceStandardsProgressIndicatorColor => const Color(0xFFFFFFFF);

  Color get welcomeTitleColor => const Color(0xFFFFFFFF);
  Color get welcomeSignInButtonColor => const Color(0xFFAD8AF9);
  Color get welcomeSignInButtonTextColor => const Color(0xFFFFFFFF);
  Color get welcomeSignUpButtonColor => const Color(0xFFFFFFFF);

  Color get loginTitleColor => const Color(0xFFFFFFFF);
  Color get loginTextInputColor => const Color(0xFFEEEEEE);
  Color get loginErrorMessageColor => const Color(0xFFF44336);
  Color get loginForgotPasswordButtonTextColor => const Color(0xFFFFFFFF);

  Color get forgotPasswordTitleColor => const Color(0xFFFFFFFF);
  Color get forgotPasswordTextInputColor => const Color(0xFFEEEEEE);
  Color get forgotPasswordResetColor => const Color(0xFFFFFFFF);
}

extension CustomFontSizes on TextTheme {
  //double get 'name' => 'fontSizeValue'
  double get welcomeTitleFontSize => 30.0;
  double get welcomeSignInSignUpButtonTextFontSize => 22.5;

  double get loginTitleFontSize => 30.0;
  double get loginTextInputFontSize => 22.0;
  double get loginErrorMessageFontSize => 13.0;
  double get loginForgotPasswordButtonTextFontSize => 15.0;

  double get forgotPaswordTitleFontSize => 37.0;
  double get forgotPasswordTextInputFontSize => 22.0;
  double get forgotPasswordResetFontSize => 24.0;
}

extension CustomFontWeights on Typography {
  //FontWeight get 'name' => 'fontWeightValue';
  FontWeight get welcomeTitleFontWeight => FontWeight.w600;
  FontWeight get welcomeSignInSignUpButtonTextFontWeight => FontWeight.w600;

  FontWeight get loginTitleFontWeight => FontWeight.w600;
  FontWeight get loginTextInputFontWeight => FontWeight.w300;
  FontWeight get loginErrorMessageFontWeight => FontWeight.w300;
  FontWeight get loginForgotPasswordButtonTextFontWeight => FontWeight.w400;

  FontWeight get forgotPasswordTitleFontWeight => FontWeight.w600;
}

extension CustomDimensions on MaterialTapTargetSize {
  double dimension({String selection, bool isHeight}) {
    switch (selection) {
      //case 'name': return isHeight ? 'height' : 'width'; break;
      case "interfaceStandardsParentCenterContainerDimension":
        return isHeight ? null : 1.0;
        break;
      case "interfaceStandardsBackButtonIconDimension":
        return isHeight ? 0.1 : 0.1;
        break;

      case "welcomeContainerDimension":
        return isHeight ? 1.0 : null;
        break;
      case "welcomeProgressContainerDimension":
        return isHeight ? 0.0 : 0.0;
        break;
      case "welcomeSignInSignUpButtonDimension":
        return isHeight ? 0.08 : 0.65;
        break;
      case "welcomeErrorMessageDimension":
        return isHeight ? 0.1 : 0.1;
        break;

      case "loginContainerDimension":
        return isHeight ? 1.0 : null;
        break;

      case "forgotPasswordContainerDimension":
        return isHeight ? 1.0 : null;
        break;
      case "forgotPasswordSendButtonDimension":
        return isHeight ? null : 1.0;
        break;
    }
  }
}

extension CustomPositions on MaterialTapTargetSize {
  double position({String selection, bool isTop}) {
    switch (selection) {
      //case 'name': return isTop? 'top' : 'left'; break;
      case "welcomeTitlePosition":
        return isTop ? 0.0875 : null;
        break;
      case "welcomeSignInButtonPosition":
        return isTop ? 0.7 : null;
        break;
      case "welcomeSignUpButtonPosition":
        return isTop ? 0.825 : null;
        break;
      case "welcomeProgressPosition":
        return isTop ? 0.8 : null;
        break;

      case "loginTitlePosition":
        return isTop ? 0.0876 : null;
        break;

      case "forgotPasswordTitlePosition":
        return isTop ? 0.35 : 0.15;
        break;
      case "forgotPasswordBackButtonPosition":
        return isTop ? 0.06 : 0.06;
        break;
      case "forgotPasswordSendButtonPosition":
        return isTop ? 0.675 : null;
        break;
    }
  }
}

class Themes {
  //Theme: Light theme
  ThemeData lightTheme() {
    return ThemeData();
  }

  //Theme: Dark theme
  ThemeData darkTheme() {
    return ThemeData();
  }

  //Mechanics: Check dark theme
  bool checkDarkTheme(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    if (brightness == Brightness.dark) {
      return true;
    }
    return false;
  }

  //Mechanics: Get dimension value
  double getDimension(BuildContext context, bool _isHeight, String _selection) {
    double value = _isHeight
        ? MediaQuery.of(context).size.height *
            Theme.of(context)
                .materialTapTargetSize
                .dimension(selection: _selection, isHeight: _isHeight)
        : MediaQuery.of(context).size.width *
            Theme.of(context)
                .materialTapTargetSize
                .dimension(selection: _selection, isHeight: _isHeight);
    return value;
  }

  //Mechanics: Get position value
  double getPosition(BuildContext context, bool _isTop, String _selection) {
    double value = _isTop
        ? MediaQuery.of(context).size.height *
            Theme.of(context)
                .materialTapTargetSize
                .position(selection: _selection, isTop: _isTop)
        : MediaQuery.of(context).size.width *
            Theme.of(context)
                .materialTapTargetSize
                .position(selection: _selection, isTop: _isTop);
    return value;
  }
}
