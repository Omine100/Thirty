import 'package:flutter/material.dart';

import 'package:thirty/standards/themes.dart';

class InterfaceStandards {
  //Variable initialization
  Themes themes = new Themes();

  //User interface: Parent center
  Widget parentCenter(BuildContext context, Widget child) {
    return Container(
      width: themes.getDimension(
          context, false, "interfaceStandardsParentCenterContainerDimension"),
      child: Center(
        child: child,
      ),
    );
  }

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

  //User interface: Header text
  Widget headerText(BuildContext context, String header) {
    return parentCenter(
        context,
        Text(
          header,
          style: TextStyle(
            color:
                Theme.of(context).colorScheme.interfaceStandardsHeaderTextColor,
            fontSize: 45.0,
          ),
        ));
  }
}
