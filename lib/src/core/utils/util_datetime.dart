import 'package:intl/intl.dart';
import 'package:yuonsoft/src/core/extensions/extension_date_time.dart';

class UtilDataTime {
  UtilDataTime._();

  static String strRegDT(DateTime source) {
    return source.isSameDate(DateTime.now())
        ? DateFormat('HH:mm:ss').format(source)
        : DateFormat('yyyy-MM-dd').format(source);
  }
}
