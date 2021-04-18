import 'package:intl/intl.dart';

class MethodStandards {
  //MECHANICS: Get current time
  //DESCRIPTION: Returns a formatted time stamp for database consistency
  //OUTPUT: Returns formatted time stamp
  String getCurrentDate() {
    String formattedDate =
        DateFormat('yyyy-MM-dd-HH:mm:ss').format(DateTime.now());
    return formattedDate;
  }
}
