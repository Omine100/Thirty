import 'package:flutter/material.dart';

import 'package:thirty/standards/themes.dart';

void main() {
  runApp(new Thirty());
}

class Thirty extends StatelessWidget {
  //Class initialiazation
  Themes themes = new Themes();

  //User interfac: Half app
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Thirty",
      debugShowCheckedModeBanner: false,
      debugShowMaterialGrid: false,
      routes: {
        // '/RootScreen': (context) => RootScreen(),
      },
      initialRoute: '/RootScreen',
      theme: themes.lightTheme(),
      darkTheme: themes.darkTheme(),
    );
  }
}
