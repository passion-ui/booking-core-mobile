import 'package:booking/presentation/presentation.dart';

class MessageState {
  final String title;
  final String? action;
  final VoidCallback? onPressed;
  final int? duration;

  MessageState({
    required this.title,
    this.action,
    this.onPressed,
    this.duration,
  });
}
