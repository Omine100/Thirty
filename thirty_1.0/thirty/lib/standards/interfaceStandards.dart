import 'package:flutter/material.dart';

import 'package:thirty/standards/themes.dart';

class InterfaceStandards {
  //Variable initialization
  Themes themes = new Themes();

  //User interface: Back button
  Widget backButton(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: Icon(
        Icons.keyboard_backspace,
        color: Theme.of(context).colorScheme.interfaceStandardsBackButtonColor,
        size: Theme.of(context)
            .materialTapTargetSize
            .interfaceStandardsBackButtonSize,
      ),
    );
  }
}
