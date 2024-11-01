import 'package:booking/presentation/presentation.dart';

class MessageEvent {}

class OnMessage extends MessageEvent {
  final String title;
  final String? action;
  final VoidCallback? onPressed;
  final int? duration;

  OnMessage({
    required this.title,
    this.action,
    this.onPressed,
    this.duration,
  });
}
