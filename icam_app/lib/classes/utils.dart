import 'package:intl/intl.dart';


// convert timestamp in milliseconds to a dateTime format
// Usage:
// int timestamp = 1529211600000;
// var datet = readTimestamp(timestamp);
// print("datet $datet");

List<String> readTimestamp(int timestamp) {

  var now = DateTime.now();
  var format = DateFormat.yMMMd();
  var date = DateTime.fromMillisecondsSinceEpoch(timestamp);
  var diff = now.difference(date);
  var time = '';

  // TODO: translate text

  if (diff.inSeconds <= 0 || diff.inSeconds > 0 && diff.inMinutes == 0
      || diff.inMinutes > 0 && diff.inHours == 0 || diff.inHours > 0 && diff.inDays == 0) {
    time = format.format(date);
  } else if (diff.inDays > 0 && diff.inDays < 7) {
    if (diff.inDays == 1) {
      time = diff.inDays.toString() + ' day ago';
    } else {
      time = diff.inDays.toString() + ' days ago';
    }
  } else {
    if (diff.inDays == 7) {
      time = (diff.inDays / 7).floor().toString() + ' week ago';
    } else {

      time = (diff.inDays / 7).floor().toString() + ' weeks ago';
    }
  }

  String dateTimeFormat = ""
      "${date.day.toString().padLeft(2,'0')}"
      "/${date.month.toString().padLeft(2,'0')}"
      "/${date.year.toString()}";
//      " - ${date.hour.toString().padLeft(2,'0')}"
//      ":${date.minute.toString().padLeft(2,'0')}"
//      ":${date.second.toString().padLeft(2,'0')}";

  List<String> dateformatted = [
    dateTimeFormat,
    time
  ];

  return dateformatted;
}
