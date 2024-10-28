import 'package:flutter/material.dart';

class Box extends StatelessWidget {
  final Widget child;

  const Box({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).shadowColor.withAlpha(25),
            spreadRadius: 1,
            blurRadius: 12,
            offset: Offset(0, 0),
          ),
        ],
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(12),
      child: child,
    );
  }
}
