import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:thirty/standards/themes.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key, this.userId});

  //Variable reference
  final String userId;

  @override
  State<StatefulWidget> createState() => new _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //Class initialization
  Themes themes = new Themes();

  //User interface: Theme selector
  Widget themeSelector(BuildContext context) {
    return Consumer<ThemeNotifier>(
      builder: (context, notifier, child) => SwitchListTile(
        inactiveThumbImage: AssetImage(
            'lib/assets/interfaceStandardsThemeSelectorMoonImage.png'),
        activeThumbImage: AssetImage(
            'lib/assets/interfaceStandardsThemeSelectorSunImage.png'),
        activeColor:
            themes.getColor(context, "interfaceStandardsThemeSelectorColor"),
        inactiveThumbColor:
            themes.getColor(context, "interfaceStandardsThemeSelectorColor"),
        onChanged: (val) {
          notifier.toggleTheme();
        },
        value: notifier.darkTheme,
      ),
    );
  }

  //User interface: Home screen
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Container(
        color: themes.getColor(context, "backgroundGradientBottomLeftColor"),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 300, right: 175),
              child: themeSelector(context),
            )
          ],
        ),
      ),
    );
  }
}
