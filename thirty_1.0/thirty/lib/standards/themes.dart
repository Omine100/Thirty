import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

//Theme: Light theme
ThemeData light = new ThemeData(
  primaryColor: Colors.red,
  brightness: Brightness.dark,
);

//Theme: Dark theme
ThemeData dark = new ThemeData(
  primaryColor: Colors.blue,
  brightness: Brightness.dark,
);

extension CustomColorScheme on ColorScheme {
  Color color({String selection, bool isDark}) {
    switch (selection) {
      //case 'name': return isDark ? 'dark' : 'light'; break;
      case "backgroundGradientTopRightColor":
        return isDark ? Color(0xFF102447) : Color(0xFFFF99D1);
        break;
      case "backgroundGradientBottomLeftColor":
        return isDark ? Color(0xFF1B1B2F) : Color(0xFFFFAB58);
        break;

      case "interfaceStandardsBackButtonColor":
        return isDark ? Color(0xFFFFAB58) : Color(0xFFFFFFFF);
        break;
      case "interfaceStandardsTitleTextColor":
        return isDark ? Color(0xFFFFAB58) : Color(0xFFFFFFFF);
        break;
      case "interfaceStandardsProgressIndicatorColor":
        return isDark ? Color(0xFFFFAB58) : Color(0xFFFFFFFF);
        break;
      case "interfaceStandardsThemeSelectorColor":
        return isDark ? Color(0xFFFFAB58) : Color(0xFFFFFFFF);
        break;
      case "interfaceStandardsLanguageSelectorColor":
        return isDark ? Color(0xFF102457) : Color(0xFFFFFFFF);
      case "interfaceStandardsLanguageSelectorTextColor":
        return isDark ? Color(0xFFFFFFFF) : Color(0xFF000000);
        break;

      case "welcomeSignInButtonColor":
        return isDark ? Color(0xFFFFAB58) : Color(0xFFFB81D1);
        break;
      case "welcomeSignInButtonTextColor":
        return isDark ? Color(0xFF000000) : Color(0xFFFFFFFF);
        break;
      case "welcomeSignUpButtonColor":
        return isDark ? Color(0xFFFFFFFF) : Color(0xFFFFFFFF);
        break;
      case "welcomeLanguageSelectorButtonColor":
        return isDark ? Color(0xFFFFFFFF) : Color(0xFFFFFFFF);
        break;

      case "loginTextInputColor":
        return isDark ? Color(0xFFFFFFFF) : Color(0xFFFFFFFF);
        break;
      case "loginTextInputIconColor":
        return isDark ? Color(0xFFFFAB58) : Color(0xFFFFFFFF);
        break;
      case "loginTextInputLineColor":
        return isDark ? Color(0xFFFFAB58) : Color(0xFFFFFFFF);
        break;
      case "loginProgressionButtonColor":
        return isDark ? Color(0xFFFFAB58) : Color(0xFFFB81D1);
        break;
      case "loginProgressionButtonIconColor":
        return isDark ? Color(0xFFFFFFFF) : Color(0xFFFFFFFF);
        break;
      case "loginAlternativeButtonTextColor":
        return isDark ? Color(0xFFFFAB58) : Color(0xFFFFFFFF);
        break;
      case "loginVisibilityButtonColor":
        return isDark ? Color(0xFFFFAB58) : Color(0xFFFFFFFF);
        break;
      case "loginForgotPasswordButtonTextColor":
        return isDark ? Color(0xFFFFAB58) : Color(0xFFFFFFFF);
        break;
      case "loginErrorMessageColor":
        return isDark ? Color(0xFFFFAB58) : Color(0xFFF44336);
        break;

      case "forgotPasswordTextInputColor":
        return isDark ? Color(0xFFFFFFFF) : Color(0xFFF44336);
        break;
      case "forgotPasswordTextInputIconColor":
        return isDark ? Color(0xFFFFAB58) : Color(0xFFFFFFFF);
        break;
      case "forgotPasswordTextInputLineColor":
        return isDark ? Color(0xFFFFAB58) : Color(0xFFFFFFFF);
        break;
      case "forgotPasswordResetColor":
        return isDark ? Color(0xFFFFAB58) : Color(0xFFF44336);
        break;

      case "introTitleColor":
        return isDark ? Color(0xFFFFAB58) : Color(0xFFF44336);
        break;
      case "introDotColor":
        return isDark ? Color(0xFFFFAB58) : Color(0xFFF44336);
        break;
      case "introDescriptionColor":
        return isDark ? Color(0xFFFFAB58) : Color(0xFFF44336);
        break;
      case "introInterfaceButtonColor":
        return isDark ? Color(0xFFFFAB58) : Color(0xFFF44336);
        break;
      default:
        return isDark ? Color(0xFFFFFFFF) : Color(0xFFFFFFFF);
        break;
    }
  }
}

extension CustomFontSizes on TextTheme {
  //double get 'name' => 'fontSizeValue'
  double get interfaceStandardsTitleFontSize => 30.0;

  double get welcomeSignInSignUpButtonTextFontSize => 22.5;

  double get loginTextInputFontSize => 22.0;
  double get loginAlternativeButtonTextFontSize => 15.0;
  double get loginForgotPasswordButtonTextFontSize => 15.0;
  double get loginErrorMessageFontSize => 13.0;

  double get forgotPasswordTextInputFontSize => 22.0;
  double get forgotPasswordResetFontSize => 24.0;

  double get introTitleFontSize => 30.0;
  double get introDescriptionFontSize => 20.0;
}

extension CustomFontWeights on Typography {
  //FontWeight get 'name' => 'fontWeightValue';
  FontWeight get interfaceStandardsTitleFontWeight => FontWeight.w600;

  FontWeight get welcomeSignInSignUpButtonTextFontWeight => FontWeight.w600;

  FontWeight get loginTextInputFontWeight => FontWeight.w300;
  FontWeight get loginAlternativeButtonTextFontWeight => FontWeight.w400;
  FontWeight get loginForgotPasswordButtonTextFontWeight => FontWeight.w400;
  FontWeight get loginErrorMessageFontWeight => FontWeight.w300;

  FontWeight get introTitleFontWeight => FontWeight.w600;
  FontWeight get introDescriptionFontWeight => FontWeight.w300;
}

extension CustomDimensions on MaterialTapTargetSize {
  double dimension({String selection, bool isHeight}) {
    switch (selection) {
      //case 'name': return isHeight ? 'height' : 'width'; break;
      case "interfaceStandardsParentCenterContainerDimension":
        return isHeight ? null : 1.0;
        break;
      case "interfaceStandardsBackButtonIconDimension":
        return isHeight ? 0.055 : 0.055;
        break;
      case "interfaceStandardsLanguageSelectorButtonDimension":
        return isHeight ? 0.05 : 0.3;
        break;
      case "interfaceStandardsLanguageSelectorButtonDimension":
        return isHeight ? 0.05 : null;
        break;

      case "welcomeContainerDimension":
        return isHeight ? 1.0 : null;
        break;
      case "welcomeBackgroundImageDimension":
        return isHeight ? 1.0 : 1.0;
      case "welcomeProgressContainerDimension":
        return isHeight ? 0.0 : 0.0;
        break;
      case "welcomeSignInSignUpButtonDimension":
        return isHeight ? 0.08 : 0.6;
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

      case "introDotDimension":
        return isHeight ? 0.0175 : null;
        break;
      case "introInterfaceButtonDimension":
        return isHeight ? 0.05 : 0.1;
        break;
      case "introInterfaceButtonIconDimension":
        return isHeight ? 0.055 : null;
        break;
    }
  }
}

extension CustomPositions on MaterialTapTargetSize {
  double position({String selection, bool isTop}) {
    switch (selection) {
      //case 'name': return isTop? 'top' : 'left'; break;
      case "interfaceStandardsThemeSelectorButtonPosition":
        return isTop ? 0.59 : 0.38;
        break;
      case "interfaceStandardsLanguageSelectorButtonPosition":
        return isTop ? 0.02 : -0.15;
        break;

      case "welcomeBackgroundLightThemeImagePosition":
        return isTop ? -0.1325 : -0.2;
        break;
      case "welcomeBackgroundDarkThemeImagePosition":
        return isTop ? -0.095 : 0.3;
        break;
      case "welcomeTitlePosition":
        return isTop ? 0.0875 : null;
        break;
      case "welcomeSignInButtonPosition":
        return isTop ? 0.67 : null;
        break;
      case "welcomeSignUpButtonPosition":
        return isTop ? 0.795 : null;
        break;
      case "welcomeProgressPosition":
        return isTop ? 0.8 : null;
        break;

      case "loginTitlePosition":
        return isTop ? 0.0876 : null;
        break;
      case "loginProgressionButtonPosition":
        return isTop ? 0.75 : null;
        break;
      case "loginAlternativeButtonPosition":
        return isTop ? 0.9 : null;
        break;
      case "loginForgotPasswordButtonPosition":
        return isTop ? 0.48 : -0.23;
        break;

      case "forgotPasswordTitlePosition":
        return isTop ? 0.325 : 0.15;
        break;
      case "forgotPasswordBackButtonPosition":
        return isTop ? 0.06 : 0.06;
        break;
      case "forgotPasswordInputPosition":
        return isTop ? 0.475 : 0.125;
        break;
      case "forgotPasswordSendButtonPosition":
        return isTop ? 0.675 : null;
        break;
    }
  }
}

class Themes {
  //Mechanics: Check dark theme
  bool checkDarkTheme(BuildContext context) {
    return Theme.of(context).primaryColor.value == 4280391411 ? false : true;
  }

  //Mechanics: Get color value
  Color getColor(BuildContext context, String _selection) {
    Color value = Theme.of(context)
        .colorScheme
        .color(selection: _selection, isDark: checkDarkTheme(context));
    return value;
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

class ThemeNotifier extends ChangeNotifier {
  //Variable initialization
  final String key = "theme";
  SharedPreferences prefs;
  bool _isDark;

  //Mechanics: Getter for brightness value
  bool get darkTheme => _isDark;

  //Mechanics: Theme notifier
  ThemeNotifier() {
    _isDark = true;
    _loadFromPrefs();
  }

  //Mechanics: Theme toggler
  toggleTheme() {
    _isDark = !_isDark;
    _saveToPrefs();
    notifyListeners();
  }

  //Mechanics: Initial preference initialization
  _initPrefs() async {
    if (prefs == null) {
      prefs = await SharedPreferences.getInstance();
    }
  }

  //Mechanics: Loading preferences
  _loadFromPrefs() async {
    await _initPrefs();
    _isDark = prefs.getBool(key) ?? true;
    notifyListeners();
  }

  //Mechanics: Saving preferences
  _saveToPrefs() async {
    await _initPrefs();
    prefs.setBool(key, _isDark);
  }
}
