import 'package:timeago/timeago.dart' as timeago;

extension DateTimeUtils on DateTime {
  String viewTime() {
    return timeago.format(this);
  }
}
