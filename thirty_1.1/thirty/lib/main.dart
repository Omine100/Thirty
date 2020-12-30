import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:thirty/standards/themes.dart';
import 'package:thirty/pages/home.dart';

void main() {
  runApp(new Thirty());
}

class Thirty extends StatefulWidget {
  @override
  _ThirtyState createState() => _ThirtyState();
}

class _ThirtyState extends State<Thirty> {
  //Class initialization
  Themes themes = new Themes();

  //User interface: Thirty app
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ThemeNotifier(),
      child: Consumer<ThemeNotifier>(
        builder: (context, ThemeNotifier notifier, child) {
          return MaterialApp(
            title: "Thirty",
            home: HomeScreen(),
            theme: notifier.darkTheme ? dark : light,
          );
        },
      ),
    );
  }
}
