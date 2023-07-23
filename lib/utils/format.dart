import 'package:intl/intl.dart';

String getFormattedRelativeTime(String dateString) {
  DateTime now = DateTime.now();
  DateTime dateTime = DateTime.parse(dateString);

  if (now.year == dateTime.year &&
      now.month == dateTime.month &&
      now.day == dateTime.day) {
    return 'Today';
  } else if (now.year == dateTime.year &&
      now.month == dateTime.month &&
      now.day - dateTime.day == 1) {
    return 'Yesterday';
  } else if (now.isBefore(dateTime)) {
    return '${DateFormat.EEEE().format(dateTime)}, ${DateFormat('dd MMM yyyy').format(dateTime)}';
  } else if (now.year == dateTime.year &&
      now.month == dateTime.month &&
      now.day - dateTime.day < 7) {
    final diffDays = now.day - dateTime.day;
    return '${diffDays.toString()} days ago';
  } else if (now.year == dateTime.year &&
      now.month == dateTime.month &&
      now.day - dateTime.day >= 7 &&
      now.day - dateTime.day < 14) {
    return '1 week ago';
  } else {
    final diffWeeks = now.difference(dateTime).inDays ~/ 7;
    return '${diffWeeks.toString()} weeks ago';
  }
}

String getFormattedDateTime(String dateString) {
  final List<String> dateParts = dateString.split('T');
  final String dateStr = dateParts[0];
  final List<String> timeParts = dateParts[1].split(':');
  final String timeStr = '${timeParts[0]}:${timeParts[1]}';

  final DateTime dateTime = DateTime.parse('$dateStr $timeStr');
  final DateFormat formatter = DateFormat('E, d MMM yyyy');
  return formatter.format(dateTime);
}
