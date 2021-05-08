import 'package:intl/intl.dart';

class MethodStandards {
  //MECHANICS: Returns current time
  //DESCRIPTION: Returns a formatted time stamp for database consistency
  //OUTPUT: Returns formatted time stamp
  String getCurrentDate() {
    String formattedDate =
        DateFormat('yyyy-MM-dd-HH:mm:ss').format(DateTime.now());
    return formattedDate;
  }

  //MECHANICS: Returns scale for items in the home page's scroll
  //OUTPUT: Double equation
  double Function(double distance) getScale() {
  }
}
