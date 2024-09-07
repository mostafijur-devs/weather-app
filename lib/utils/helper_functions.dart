
import 'package:intl/intl.dart';
import 'package:weather_app/utils/constants.dart';

String getFormattedDataTime( num dt , {String pattern =' MMM dd, hh:mm a'}){
  return DateFormat(pattern).format(DateTime.fromMillisecondsSinceEpoch(dt.toInt()*1000));
}
String getIconUrl(String icon) => '$iconUrlPrefix$icon$iconUrlSuffix';