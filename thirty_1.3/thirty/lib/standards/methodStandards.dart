import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:thirty/standards/languageStandards.dart';

class MethodStandards {
  //CLASS INITILIAZATION

  //MECHANICS: Returns current time
  //DESCRIPTION: Returns a formatted time stamp for database consistency
  //OUTPUT: Returns formatted time stamp
  String getCurrentDate() {
    String formattedDate =
        DateFormat('yyyy-MM-dd-HH:mm:ss').format(DateTime.now());
    return formattedDate;
  }

  //MECHANICS: Returns current day
  //OUTPUT: String of current day
  String getCurrentDay() {
    int currentDay = DateTime.now().day;
    return currentDay.toString();
  }

  //MECHANICS: Returns current year
  //OUTPUT: String of current year
  String getCurrentYear() {
    int currentYear = DateTime.now().year;
    return currentYear.toString();
  }

  //MECHANICS: Returns current weekday
  //DESCRIPTION: Gets the current day in number format and then converts into a
  //          string for use
  //OUTPUT: String of current weekday
  String getCurrentWeekday(BuildContext context) {
    int currentDay = DateTime.now().weekday;
    switch (currentDay) {
      case (1):
        return getTranslated(context, "currentDay1");
        break;
      case (2):
        return getTranslated(context, "currentDay2");
        break;
      case (3):
        return getTranslated(context, "currentDay3");
        break;
      case (4):
        return getTranslated(context, "currentDay4");
        break;
      case (5):
        return getTranslated(context, "currentDay5");
        break;
      case (6):
        return getTranslated(context, "currentDay6");
        break;
      case (7):
        return getTranslated(context, "currentDay7");
        break;
      default:
        return "null";
        break;
    }
  }

  //MECHANICS: Returns current month
  //DESCRIPTION: Gets the current month in number format and then converts into a
  //          string for use
  //INTEGER INPUT: 'time' to be converted
  //OUTPUT: String of today's month
  String getCurrentMonth(BuildContext context, int time) {
    int currentMonth = time;
    switch (currentMonth) {
      case (1):
        return getTranslated(context, "currentMonth1");
        break;
      case (01):
        return getTranslated(context, "currentMonth1");
        break;
      case (2):
        return getTranslated(context, "currentMonth2");
        break;
      case (02):
        return getTranslated(context, "currentMonth2");
        break;
      case (3):
        return getTranslated(context, "currentMonth3");
        break;
      case (03):
        return getTranslated(context, "currentMonth3");
        break;
      case (4):
        return getTranslated(context, "currentMonth4");
        break;
      case (04):
        return getTranslated(context, "currentMonth4");
        break;
      case (5):
        return getTranslated(context, "currentMonth5");
        break;
      case (05):
        return getTranslated(context, "currentMonth5");
        break;
      case (6):
        return getTranslated(context, "currentMonth6");
        break;
      case (06):
        return getTranslated(context, "currentMonth6");
        break;
      case (7):
        return getTranslated(context, "currentMonth7");
        break;
      case (07):
        return getTranslated(context, "currentMonth7");
        break;
      case (8):
        return getTranslated(context, "currentMonth8");
        break;
      case (08):
        return getTranslated(context, "currentMonth8");
        break;
      case (9):
        return getTranslated(context, "currentMonth9");
        break;
      case (09):
        return getTranslated(context, "currentMonth9");
        break;
      case (10):
        return getTranslated(context, "currentMonth10");
        break;
      case (11):
        return getTranslated(context, "currentMonth11");
        break;
      case (12):
        return getTranslated(context, "currentMonth12");
        break;
      default:
        return "null";
        break;
    }
  }
}
