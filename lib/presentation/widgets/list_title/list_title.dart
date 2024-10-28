import 'package:flutter/material.dart';

enum DescriptionPosition { bottom, right }

class ListTitle extends StatelessWidget {
  final Widget? leading;
  final String title;
  final dynamic description;
  final DescriptionPosition descriptionPosition;
  final VoidCallback onPress;

  const ListTitle({
    super.key,
    this.leading,
    required this.title,
    this.description,
    this.descriptionPosition = DescriptionPosition.bottom,
    required this.onPress,
  });

  Widget buildDescription(BuildContext context, DescriptionPosition position) {
    if (description != null && descriptionPosition == position) {
      if (description is String) {
        return Text(
          description,
          style: Theme.of(context).textTheme.labelSmall,
        );
      }
      return description as Widget;
    }
    return SizedBox.shrink();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Container(
        constraints: BoxConstraints(minHeight: 40.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            leading ?? SizedBox.shrink(),
            SizedBox(width: 8.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  buildDescription(context, DescriptionPosition.bottom),
                ],
              ),
            ),
            buildDescription(context, DescriptionPosition.right),
            if (description == null || description is String)
              Icon(Icons.chevron_right),
          ],
        ),
      ),
    );
  }
}
